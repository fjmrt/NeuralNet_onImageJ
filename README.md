# NeuralNet_onImageJ
Real time handwriting number recognition based on 2 layers dense neural net on ImageJ.

## DEMO
![demo_movie](https://user-images.githubusercontent.com/40162543/44721586-5ab81600-ab05-11e8-9789-4282a9aca3c0.gif)


## contents
- mnist2layersKeras.py
- mnist2layersWeight.txt
- mnist_2layers.ijm

### mnist2layersKeras.py
This program imports MNIST dataset, executes 2 layers dense neural net learning by Keras.  The parameters of the neural net (weights and biases) will be saved as text file in '/Applications/ImageJ/plugins/mymacro/'.  Please install imageJ and create mymacro folder in 'pulgins' folder before running this program.

### mnist2layersWeight.txt
The example output of mnist2layersKeras.py.

### mnist_2layers.ijm
This program is written in ImageJ macro.  Handwriting number will be estimated based on neural net with the parameters in mnist2layersWeight.txt.

## How to use
### Handwriting recognition
1. Insatall imageJ, create 'mymacro' folder in 'plugin' folder.
2. Put 'mnist2layersWeight.txt' and 'mnist_2layers.ijm' in mymacro folder.
3. Start ImageJ.
4. You can see mymacro in Pulgin menu. Select "mnist 2layers" in plugin menu.
5. GUI will guide you. 20 pixel width paintbrush tool is optimal for drawing.


- If you activate "show probability", the probability distribution will be shown.
- Press OK after drawing a number, then you get popup with estimated number and a bar graph of probability distribution.
- Drawn image is binned by average into 28x28 pix during estimation.

### neural net learning
Just run the program in appropriate environment.  Please confirm the package requirements are satisfiled.
