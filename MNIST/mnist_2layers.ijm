macro "mnist_2layers"{
	/**
		import weights and biases of mnist2layersKeras.py,
		estimate the number drawn in input image.

		User-defined function:
		ToFloat, PlotProbability, Dense, Relu, Softmax

		author:
		Taihei Fujimori
	*/

	VISIBLE = 0;
	DIR = getDirectory("plugins")+"mymacro/";

	////////////// import weights & biases /////////////
	Wbs = split(File.openAsString(DIR+"mnist2layersWeight.txt"),"\]\[");
	dense1w = ToFloat(Wbs[0]);
	dense1b = ToFloat(Wbs[1]);
	dense2w = ToFloat(Wbs[2]);
	dense2b = ToFloat(Wbs[3]);

	////////////////// main process /////////////////
	init = 1;
	Dialog.create("mnist");
	Dialog.addCheckbox("show probability", 0);
	Dialog.show();
	SHOWPROB = Dialog.getCheckbox();

	while(1){
		/////// wait input ///////
		if(init){
			newImage("mnist input", "32-bit black", 224, 224, 1);
			imid = getImageID;
		}
		setForegroundColor(255, 255, 255);
		if (getVersion<="1.49t") {
			run("Paintbrush Tool Options...", "brush=20");
		}
		setTool("Paintbrush Tool");

		waitForUser("mnist", "Draw a number, then click OK.");


		/////// make input array ///////
		run("Duplicate...", "title=im");
		setBatchMode("hide");
		run("Bin...", "x=8 y=8 bin=Average");
		resetMinAndMax();
		height = getHeight;
		width = getWidth;
		input = newArray(height*width);
		for(i=0;i<height;i++){
			for(j=0;j<width;j++){
				input[j + i*width] = getPixel(j,i);
			}
		}
		if(!VISIBLE){close("im");}

		/////// prediction ///////
		layer1_output = Dense(input,dense1w,dense1b);
		layer1_output = Relu(layer1_output);
		layer2_output = Dense(layer1_output,dense2w,dense2b);
		 final_output = Softmax(layer2_output);

		/////// find max ///////
		Array.getStatistics(final_output, min, max, mean, stdDev);
		idx = 0;
		while(final_output[idx] != max){
			idx++;
		}

		/////// show results ///////
		init = 0;
		if(SHOWPROB){
			PlotProbability(final_output);
			pltid = getImageID;
		}
		setBatchMode("show");

		Dialog.create("mnist");
		Dialog.addMessage("The number is "+idx+".\n next trial => OK \n"+"finish => cancel");
		Dialog.show();

		if(SHOWPROB){
			selectImage(pltid);
			close();
		}
		selectImage(imid);
		run("Set...","value=0");
	}
}


///////////////  functions for neural net ///////////////

function Dense(input, weight, bias){

	unit_num = weight.length/input.length;
	output = newArray(unit_num);

	for(i=0;i<unit_num;i++){
		for(j=0;j<input.length;j++){
			output[i] += input[j] * weight[j + i*input.length];
		}
		output[i] += bias[i];
	}
	return output;
}

function Relu(input){

	input_size = input.length;
	output = newArray(input_size);

	for(i=0;i<input_size;i++){
		if(input[i] > 0){
			output[i] = input[i];
		}
	}
	return output;
}

function Sigmoid(input){

	input_size = input.length;
	output = newArray(input_size);

	for(i=0;i<input_size;i++){
		output[i] = 1/(1+exp(-1*input[i]));
	}
	return output;
}

function Softmax(input){

	array_size = input.length;
	output = newArray(array_size);
	Array.getStatistics(input, min, max, mean, stdDev);

	array_sum = 0;
	for(i=0;i<array_size;i++){
		output[i] = exp(input[i] - max);
		array_sum += output[i];
	}
	for(i=0;i<array_size;i++){
		output[i] = output[i]/array_sum;
	}
	return output;
}

///////////////  utility functions ///////////////

function ToFloat(input){

	temp = split(input," \n");
	output = newArray(temp.length);
	for(i=0;i<temp.length;i++){
		output[i] = parseFloat(temp[i]);
	}
	return output;
}

function PlotProbability(final_output){
	
	Plot.create("mnist probability", "number", "probability");
	Plot.setLimits(-1, 10, 0, 1.1 );
	Plot.setColor("black");
	Plot.setFormatFlags("1100001100");
	Plot.setJustification("left");
	Plot.addText("1.0", -0.05, 0.12);
	Plot.addText("0.0", -0.05, 1.04);
	for(i=0;i<10;i++){Plot.addText(toString(i), i/10.99+0.085, 1.08);}
	Plot.show;
	for(i=0;i<final_output.length;i++){
		probability = final_output[i] + 0.0000001;
		x1 = i-0.2;
		x2 = i+0.2;
		Polx = newArray(x1,x2,x2,x1);
		Poly = newArray(0,0,probability,probability);
		toUnscaled(Polx, Poly);
		makeSelection("polygon",Polx,Poly);
		run("Overlay Options...", "stroke=blue width=1 fill=blue");
		run("Add Selection...");
	}
	run("Select None");
	Plot.freeze();
	run("Flatten");
	rename("mnist probability");
}
