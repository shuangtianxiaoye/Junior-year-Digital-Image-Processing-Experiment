import tensorflow as tf
import urllib
from  tensorflow.examples.tutorials.mnist  import  input_data
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image, ImageFilter
import random
import skimage

#保存绘制训练准确率、测试准确率、损失函数曲线所需数组
train_acc_y = np.zeros(50)
test_acc_y = np.zeros(50)
loss_y = np.zeros(50)

mnist = input_data.read_data_sets("MNIST_data/", one_hot = True)
#建立BP神经网络模型
num_classes = 10#数据类型0-9
input_size = 784#28*28
hidden_units_size = 30#层节点数30
batch_size = 100#
training_iterations = 50000#迭代次数
# 设置变量
X = tf.placeholder (tf.float32, shape = [None, input_size])
Y = tf.placeholder (tf.float32, shape = [None, num_classes])
W1 = tf.Variable (tf.random_normal ([input_size, hidden_units_size],
                                    stddev = 0.1),name='weight1')# = 30#正态分布随机数num_classes
B1 = tf.Variable (tf.constant (0.1),
                 name='biases1')#常数为0.1，形状为（1,1）num_classes [hidden_units_size],
W2 = tf.Variable (tf.random_normal ([hidden_units_size,
                                     num_classes], stddev = 0.1),name='weight2')#正态分布随机数
B2 = tf.Variable (tf.constant (0.1),
                 name='biases2')# [num_classes],
# 搭建计算网络 使用 relu 函数作为激励函数 这个函数就是 y = max (0,x) 的一个类似线性函数 拟合程度还是不错的
# 使用交叉熵损失函数 这是分类问题例如 ： 神经网络 对率回归经常使用的一个损失函数
#第1层神经网络
hidden_opt = tf.matmul (X, W1) + B1#矩阵运算
final_opt = tf.nn.relu (hidden_opt)#激活函数
#第2层神经网络
final_opt = tf.matmul (final_opt, W2) + B2#矩阵运算 #hidden_opt
final_opt = tf.nn.relu (final_opt)#激活函数,最终的输出结果
loss = tf.reduce_mean (
    tf.nn.softmax_cross_entropy_with_logits (labels = Y, logits = final_opt))#损失函数,交叉熵方法
opt = tf.train.GradientDescentOptimizer (0.1).minimize (loss)
init = tf.global_variables_initializer ()#全局变量初始化
correct_prediction = tf.equal (tf.argmax (Y, 1), tf.argmax (final_opt, 1))
accuracy = tf.reduce_mean (tf.cast (correct_prediction, 'float'))#将张量转化成float
# 进行计算 打印正确率
sess = tf.Session ()#生成能进行TensorFlow计算的类
saver=tf.train.Saver()
sess.run (init)
for i in range (training_iterations) :
    batch_x,batch_y = mnist.train.next_batch (batch_size)#每次迭代选用的样本数100
    #print(batch_input.shape)
    #print(batch_labels)
    _,training_loss = sess.run ([opt, loss], feed_dict = {X: batch_x, Y: batch_y})
    if (i+1) % 1000 == 0 :
        train_accuracy = accuracy.eval (session = sess, feed_dict = {X: batch_x,Y: batch_y})
        test_acc = accuracy.eval (session = sess, feed_dict = {X: mnist.test.images[:1000],Y: mnist.test.labels[:1000]})

        print ("step : %d, training accuracy = %g " % (i+1, train_accuracy))
        train_acc_y[(i+1)//1000-1]=train_accuracy #保存数据
        print("step : %d, test accuracy = %g " % (i+1, test_acc))
        test_acc_y[(i+1)//1000-1]=test_acc #保存数据
        print("step : %d, loss = %g " % (i+1, training_loss))
        loss_y[(i+1)//1000-1]=training_loss #保存数据
        saver.save( sess,"path/weights.ckpt")

###测试集输出结果可视化

#绘制曲线
x = np.zeros(50);

for i in range(50) :
    x[i] = i+1

#训练准确率
plt.figure(1)
plt.plot(x,train_acc_y)
plt.xlabel("*1000")
plt.title("train_accuracy")
plt.show()
#测试准确率
plt.figure(2)
plt.plot(x,test_acc_y)
plt.xlabel("*1000")
plt.title("test_accuracy")
plt.show()
#损失函数
plt.figure(3)
plt.plot(x,loss_y)
plt.xlabel("*1000")
plt.ylabel("loss")
plt.title("LOSS")
plt.show()

#随机选取3张图片展示
for i in range(0,3):
    r = random.randint(0,mnist.test.num_examples-1)# 随机数
    # 标签随机图片下标
    print("随机图片标签：",end="")
    print(sess.run(tf.argmax(mnist.test.labels[r:r+1],1)))
    # 预测图片下标
    print("预测识别结果：",end="")
    print(sess.run(tf.argmax(final_opt,1),feed_dict={X:mnist.test.images[r:r+1]}))
    # 显示图片
    plt.figure(4+i)
    plt.imshow(mnist.test.images[r:r+1].reshape(28,28),cmap='cool')
    plt.show()

noisevar = [0.0001,0.001,0.01,0.1]  #高斯噪声方差分别选取0.0001 0.001 0.01 0.1

for i in range(4):
    r = random.randint(0,mnist.test.num_examples-1)# 随机数
    I = mnist.test.images[r:r+1] #未加噪声图片
    Inoise = skimage.util.random_noise(I, mode='gaussian', var=noisevar[i])  #噪声图片
    print("高斯噪声方差：",end="")
    print(noisevar[i])
    print("加噪图片预测识别结果：",end="")
    print(sess.run(tf.argmax(final_opt,1),feed_dict={X:Inoise})) #噪声图片预测结果
    print("实际图片标签：",end="")
    print(sess.run(tf.argmax(mnist.test.labels[r:r+1],1))) #实际结果
    plt.figure(7+i)
    plt.imshow(Inoise.reshape(28,28),cmap='cool')
    plt.show()

# 加高斯噪声准确率
# 随机选取200张图片测试加噪声后的准确率
# 高斯噪声方差分别选取0.0001 0.001 0.01 0.1
noise = np.zeros(4)  #存放不同噪声方差的准确率
pre = np.zeros(1)
rel = np.zeros(1)
noisevar = [0.0001,0.001,0.01,0.1]  #高斯噪声方差分别选取0.0001 0.001 0.01 0.1
for i in range(0,4):
    for j in range(0,200):
        r = random.randint(0,mnist.test.num_examples-1) #随机数
        I = mnist.test.images[r:r+1] #未加噪声图片
        Inoise = skimage.util.random_noise(I, mode='gaussian', var=noisevar[i])  #噪声图片
        pre[0] = sess.run(tf.argmax(final_opt,1),feed_dict={X:Inoise}) #噪声图片预测结果
        rel[0] = sess.run(tf.argmax(mnist.test.labels[r:r+1],1)) #实际结果
        if pre[0] != rel[0]:
            noise[i] = noise[i] + 1

    noise[i] = noise[i]/200  #归一化

# 绘制噪声曲线
x = np.zeros(4)
for i in range(4) :
    x[i] = i-4

plt.figure(10)
plt.plot(x,noise)
plt.xlabel("noisevar/lg(var)")
plt.ylabel("error")
plt.title("NOISE")
plt.show()






'''
#图片展示2
#随机数
r = random.randint(0,mnist.test.num_examples-1)

# 标签随机图片下标
print("随机图片标签：",end="")
print(sess.run(tf.argmax(mnist.test.labels[r:r+1],1)))
# 预测图片下标
print("预测识别结果：",end="")
print(sess.run(tf.argmax(final_opt,1),feed_dict={X:mnist.test.images[r:r+1]}))

# 显示图片
plt.figure(1)
plt.imshow(mnist.test.images[r:r+1].reshape(28,28),cmap='cool')
plt.show()

#图片展示3
#随机数
r = random.randint(0,mnist.test.num_examples-1)

# 标签随机图片下标
print("随机图片标签：",end="")
print(sess.run(tf.argmax(mnist.test.labels[r:r+1],1)))
# 预测图片下标
print("预测识别结果：",end="")
print(sess.run(tf.argmax(final_opt,1),feed_dict={X:mnist.test.images[r:r+1]}))

# 显示图片
plt.figure(1)
plt.imshow(mnist.test.images[r:r+1].reshape(28,28),cmap='cool')
plt.show()

#绘制曲线
x = np.zeros(50);

for i in range(50) :
    x[i] = i+1

plt.figure(2)
plt.plot(x,train_acc_y)
plt.xlabel("*1000")
plt.title("train_accuracy")
plt.show()

plt.figure(3)
plt.plot(x,test_acc_y)
plt.xlabel("*1000")
plt.title("test_accuracy")
plt.show()

plt.figure(4)
plt.plot(x,loss_y)
plt.xlabel("*1000")
plt.ylabel("loss")
plt.title("LOSS")
plt.show()
'''