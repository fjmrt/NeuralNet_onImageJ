'''
	load mnist data, train neural net composed of 2 dense layers.
	weights and biases are saved in 'mymacro' folder in imageJ plugin folder.

	requirement:
	! pip install tensorflow==1.0.1
	! pip install Keras==2.0.2
	
	author:
	Taihei Fujimori
'''

SAVEDIR = '/Applications/ImageJ/plugins/mymacro/'

import sys,os
os.chdir(SAVEDIR)

from keras.datasets import mnist
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense, Activation
from keras.optimizers import SGD
from keras.callbacks import ModelCheckpoint
import time

##### load mnist data #####
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train.reshape(60000,784).astype('float32')
x_test = x_test.reshape(10000,784).astype('float32')

x_train /= 255
x_test /= 255

y_train = np_utils.to_categorical(y_train, 10)
y_test = np_utils.to_categorical(y_test, 10)

##### network construction #####
model_2layers = Sequential()
model_2layers.add(Dense(input_dim=784,units=64))
model_2layers.add(Activation('relu'))
model_2layers.add(Dense(units=10))
model_2layers.add(Activation('softmax'))
model_2layers.compile(loss="categorical_crossentropy",optimizer=SGD(lr=0.01,momentum=0.9,nesterov=True),metrics=["accuracy"])
# check = ModelCheckpoint("model2layersCheckpoints.hdf5")

## record start time
starttime = time.time()

##### training #####
# history = model_2layers.fit(x_train,y_train,nb_epoch=20,validation_split=0.2,batch_size=32,callbacks=[check])
history = model_2layers.fit(x_train,y_train,epochs=20,validation_split=0.2,batch_size=32)

##### test #####
loss_and_metrics = model_2layers.evaluate(x_test,y_test)
print("\nloss:{} accuracy:{}".format(loss_and_metrics[0],loss_and_metrics[1]))

## show elapsed time
endtime = time.time()
print("elapsed time: {0} seconds．".format(endtime-starttime))

##### save weights and biases #####
import numpy as np
np.set_printoptions(threshold=np.inf)
Ws = model_2layers.get_weights()
with open('mnist2layersWeight.txt', 'w') as f:
    for idx in range(len(Ws)):
        f.write(str(Ws[idx].T.reshape(-1,)))


##### prediction #####
# import matplotlib.pyplot as plt
# %matplotlib inline
# index = 5
# plt.imshow(x_test[index,:].reshape(28,28))
# print('\n                            this is %d.' % np.argmax(model_2layers.predict(x_test[index:(index+1),:]),axis=1))

##### save visualized network #####
# requirement:
# ! brew install graphviz
# ! pip install pydot
# ! pip install pydot_ng

# from keras.utils.vis_utils import plot_model
# plot_model(model_2layers,to_file="model_2layers.png",show_shapes=True, show_layer_names=True)
