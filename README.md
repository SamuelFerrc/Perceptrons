# 🧠 Perceptron

This repository aims to explain the smallest unit of a neural network — the **Perceptron** — through practical computational examples.

---

## 📌 What is a Perceptron?

It’s completely normal to feel unsure about what perceptrons are when starting out in neural networks.  
A perceptron is the most basic unit of a neural network — meaning it plays a role similar to a neuron in the human brain.

Understanding this analogy is fundamental to grasping how perceptrons work at their core.

---

## 🧬 Structure of a Biological Neuron

A neuron in the human brain acts as a basic cell responsible for:
- Receiving information  
- Processing it  
- Transmitting it forward  

---

## ⚙️ Structure of a Perceptron

A perceptron is a **linear binary classifier** that follows the same idea:
- Receives input  
- Processes it  
- Produces an output  

This process is defined by three fundamental steps.

---

## 🔄 Three Fundamental Processes

### 1. 📊 Sampling
The sampling step consists of selecting data to train the perceptron.  
These data must already be labeled in a binary way (**0 or 1**).

---

### 2. 🏋️ Training
Using the sampled data, the perceptron leverages its linear nature to create an **N-dimensional decision boundary** capable of separating the data.

---

### 3. 🔍 Classification
The decision boundary generated during training is used to classify new data based on their position relative to that boundary.

---

## 🧾 Conclusion

Due to its binary and linear nature, the perceptron simulates a simplified version of how neurons operate in the human brain.  

This repository provides practical demonstrations to support a deeper understanding of perceptrons and their role within neural networks.

---

# 🚀 Execution

To process data using perceptrons, three distinct models were developed, each responsible for a specific stage in the cleaning of two-dimensional images.

These images must allow for a simple binary separation, which is essential for correct segmentation of the region of interest.

---

## 📂 Dataset

The experiments use the **Visible Human Data Male**, publicly available from the U.S. National Library of Medicine, ensuring:
- Standardization  
- Reproducibility  

---

## 🧩 Implemented Models

### 🎨 RGB Perceptron
Responsible for the initial segmentation of the region of interest by separating the RGB channels of the image.

- 📁 Directory: `01-RGB Perceptron/Perceptron_01`
- ⚠️ Requires execution of all three pipeline processes

---

### ➖ Horizontal Perceptron
Removes noise with predominantly **horizontal orientation** from the segmented region.

- 📁 Directory: `02-Horizontal Perceptron/PipelinePerc`
- ⚠️ Requires execution of all three pipeline processes

---

### ➕ Vertical Perceptron
Removes noise with predominantly **vertical orientation** in the region of interest.

- 📁 Directory: `03-Vertical Perceptron`
- ⚠️ Requires execution of all three pipeline processes

---

## 🧠 Approach

This modular approach allows:
- Progressive refinement of the image  
- Combination of color-based segmentation  
- Directional filtering for noise removal  

Resulting in improved **binary segmentation quality**.

---

## 📊 Results

All results can be found in:
