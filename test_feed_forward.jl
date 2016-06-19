using Mocha
using PyCall
using RDatasets
#using JLD

## pyimport ##
const train_test_split = pyimport("sklearn.cross_validation")[:train_test_split]
const classification_report = pyimport("sklearn.metrics")[:classification_report]

#=
  Mocha.jlによるFFNNを用いた
  Fisherのアヤメのデータ分類プログラム
=#

## cpu_backend ##
backend = DefaultBackend()
init(backend)

## iris_data ##
iris = dataset("datasets","iris")

## dummy定義 ##
d = Dict("setosa"=> [0.,0.,1.], "versicolor"=>[0.,1.,0.], "virginica"=>[1.,0.,0.])

## split_data ##
x = convert(Array, iris[1:4])
y = hcat([d[l] for l in iris[5]]...)'
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.5)

## trainモデル (4→10→10→3のFFNN) #
train_layer = MemoryDataLayer(batch_size=10, data=Array[x_train', y_train'])
hidden_layer = InnerProductLayer(name="hidden", neuron = Neurons.ReLU(), output_dim = 7, tops=[:hidden], bottoms=[:data])
out_layer = InnerProductLayer(name="out", output_dim = 3, tops=[:out], bottoms=[:hidden])
softmax_layer = SoftmaxLayer(name="res", tops=[:res], bottoms=[:out])
loss_layer = BinaryCrossEntropyLossLayer(name="loss", bottoms=[:res, :label])

net = Net("iris_train", backend, [loss_layer, softmax_layer, out_layer, hidden_layer, train_layer])

## モデルの可視化 ##
println(net)

## 学習 ##
method = SGD()
params = make_solver_parameters(method, max_iter=1000)
solver = Solver(method, params)
add_coffee_break(solver, TrainingSummary(), every_n_iter=100)
solve(solver, net)

## モデルの保存 ##
#jld = jldopen("model.jld", "w")
#save_network(jld, net)
#close(jld)

## testモデル ##
test_layer = MemoryDataLayer(batch_size = 1, data = Array[x_test'], tops = [:data])
test_net = Net("iris_test", backend, [softmax_layer, out_layer, hidden_layer, test_layer])

## パラメータ読み込み ##
#model = jldopen("model.jld")
#load_network(model, test_net)
#close(model)

## 結果 ##
out_true, out_pred = [], []
for i in collect(1:length(y_test[:,1]))
  forward(test_net)
  true_indx = findmax(y_test[i, :])[2]
  pred_indx = findmax(test_net.output_blobs[:res].data)[2]
  #println(true_indx,":",pred_indx)
  push!(out_true, true_indx)
  push!(out_pred, pred_indx)
end
println(classification_report(out_true, out_pred))


shutdown(backend)
