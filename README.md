# NeuralNet_onImageJ
Real time handwriting number recognition based on 2 layers dense neural net on ImageJ.

## contents
- mnist2layersKeras.py
- mnist2layersWeight.txt
- mnist_2layers.ijm

### mnist2layersKeras.py
This program imports MNIST dataset, executes 2 layers dense neural net learning by Keras.  The parameters of the neural net (weights and biases) will be saved as .txt file in '/Applications/ImageJ/plugins/mymacro/'.  Please install imageJ and create mymacro folder in 'pulgins' folder before running this program.

### mnist2layersWeight.txt
The example output of mnist2layersKeras.py.

### mnist_2layers.ijm
This program is written in ImageJ macro.  Handwriting number will be estimated based on neural net with the parameters in mnist2layersWeight.txt.

## How to use
### Handwriting recognition
1. Insatall imageJ, create 'mymacro' folder.
2. Put 'mnist2layersWeight.txt' and 'mnist_2layers.ijm' file in it.
3. Start ImageJ
4. You can see mymacro in Pulgin menu, so select "mnist 2layers" in it.
5. GUI will guide you. 20 pixel width paintbrush tool is optimal.


- If you check "show probability", the probability distribution will be shown.
- Press OK after drawing a number, then you get popup with estimated number and a bar graph of probability distribution.
- Drawn image is binned by average into 28x28 pix during estimation.

### neural net learning
Just run at appropriate environment.  Please confirm the package requirements are satisfiled.
