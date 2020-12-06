# NeuralNet_onImageJ
On-the-spot handwriting number recognition based on a two-layers dense neural net on ImageJ.

## DEMO
<div align="center">
<img src="https://user-images.githubusercontent.com/40162543/46203583-3a25ea80-c355-11e8-8b0d-37e3e36d5a5b.gif" width="70%">
</div>


## Contents
- mnist2layersKeras.py
- mnist2layersWeight.txt
- mnist_2layers.ijm

### mnist2layersKeras.py
This program imports MNIST dataset, and executes two-layers dense neural net trained using Keras.  The parameters of the neural net (weights and biases) will be saved as a text file in '/Applications/ImageJ/plugins/mymacro/'.  Please install imageJ and create 'mymacro' folder in the 'plugins' folder before running this program.

### mnist2layersWeight.txt
An example output of mnist2layersKeras.py.

### mnist_2layers.ijm
This program is written in ImageJ macro.  Handwriting number will be estimated based on the two-layers neural net with the parameters in mnist2layersWeight.txt.

## How to use
### handwriting recognition
1. Install imageJ, create 'mymacro' folder in 'plugins' folder.
2. Put 'mnist2layersWeight.txt' and 'mnist_2layers.ijm' in mymacro folder.
3. Start ImageJ.
4. You can see 'mymacro' in Plugin menu. Select 'mnist 2layers' in plugin menu.
5. GUI will guide you. 20-pixel width paintbrush tool is optimal for drawing a number.


- If you activate "show probability", the probability distribution will be shown.
- Press OK after drawing a number, then you get a popup with an estimated number and a bar plot of the probability distribution.
- The image is binned by average into 28x28 pix during estimation.

### neural net learning
Run the python program 'mnist2layersKeras.py' in an appropriate environment.  Please confirm the package requirements are fulfilled.