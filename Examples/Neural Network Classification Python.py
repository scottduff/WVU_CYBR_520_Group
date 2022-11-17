# Import libraries
import pandas
import numpy as np
import matplotlib.pyplot as plt
import sklearn.model_selection
import sklearn.metrics
import sklearn.preprocessing
import keras


# Generate a data set with spirals
# http://cs231n.github.io/neural-networks-case-study/
def generate_spirals():
    N = 400  # number of points per class
    D = 2  # dimensionality
    K = 3  # number of classes
    data = np.zeros((N * K, D))  # data matrix (each row = single example)
    labels = np.zeros(N * K, dtype='uint8')  # class labels
    for j in range(K):
        ix = range(N * j, N * (j + 1))
        r = np.linspace(0.0, 1, N)  # radius
        t = np.linspace(j * 4, (j + 1) * 4, N) + np.random.randn(N) * 0.2  # theta
        data[ix] = np.c_[r * np.sin(t), r * np.cos(t)]
        labels[ix] = j
    # Save to a csv file
    f = open('./spirals.csv', 'w')
    f.write('x,y,label\n')
    for i in range(len(labels)):
        f.write(str(data[i][0]) + ',' + str(data[i][1]) + ',' + str(labels[i]) + '\n')
    f.close()


# Visualize data set
def visualize_data_set(data):
    # Load data set
    #ds = pandas.read_csv('./spirals.csv')
    ds = pandas.read_csv(data)
    # Print first 5 rows in data set
    print('--- First 5 rows ---')
    print(ds.head())
    # Print the shape
    print('\n--- Shape of data set ---')
    print(ds.shape)
    # Print class distribution
    print('\n--- Class distribution ---')
    #print(ds.groupby('label').size())
    print(ds.groupby('type').size())
    # Visualize data set
    figure = plt.figure(figsize=(12, 8))
    #figure.suptitle('Spirals', fontsize=16)
    figure.suptitle('Spam', fontsize=16)
    #grouped_dataset = ds.groupby('label')
    grouped_dataset = ds.groupby('type')
    #labels = ['0', '1', '2']
    labels = ['spam', 'nonspam']
    for i, group in grouped_dataset:
        plt.scatter(group['remove'], group['mail'], label=labels[int(i)])
    plt.ylabel('mail')
    plt.xlabel('remove')
    plt.legend()
    # plt.show()
    #plt.savefig('./spirals.png')
    plt.savefig('./spam.png')


# Train and evaluate
def train_and_evaluate(X_train, Y_train, X_test, Y_test):
    # Create layers (Functional API)
    inputs = keras.layers.Input(shape=(57,), dtype='float32', name='input_layer')  # Input (2 dimensions)
    outputs = keras.layers.Dense(64, activation='relu', name='hidden_layer')(inputs)  # Hidden layer
    outputs = keras.layers.Dense(2, activation='softmax', name='output_layer')(outputs)  # Output layer (3 labels)
    # Create a model from input layer and output layers
    model = keras.models.Model(inputs=inputs, outputs=outputs, name='neural_network')
    # Compile the model (binary_crossentropy if 2 classes)
    model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
    # Convert labels to categorical: categorical_crossentropy expects targets
    # to be binary matrices (1s and 0s) of shape (samples, classes)
    Y_binary = keras.utils.to_categorical(Y_train, num_classes=2, dtype='int')
    # Train the model on the train set (output debug information)
    model.fit(X_train, Y_binary, batch_size=1, epochs=100, verbose=1)
    # Save the model (Make sure that the folder exists)
    model.save('./keras_nn.h5')
    # Evaluate on training data
    print('\n-- Training data --')
    predictions = model.predict(X_train)
    accuracy = sklearn.metrics.accuracy_score(Y_train, np.argmax(predictions, axis=1))
    print('Accuracy: {0:.2f}'.format(accuracy * 100.0))
    print('Classification Report:')
    print(sklearn.metrics.classification_report(Y_train, np.argmax(predictions, axis=1)))
    print('Confusion Matrix:')
    print(sklearn.metrics.confusion_matrix(Y_train, np.argmax(predictions, axis=1)))
    print('')
    # Evaluate on test data
    print('\n---- Test data ----')
    predictions = model.predict(X_test)
    accuracy = sklearn.metrics.accuracy_score(Y_test, np.argmax(predictions, axis=1))
    print('Accuracy: {0:.2f}'.format(accuracy * 100.0))
    print('Classification Report:')
    print(sklearn.metrics.classification_report(Y_test, np.argmax(predictions, axis=1)))
    print('Confusion Matrix:')
    print(sklearn.metrics.confusion_matrix(Y_test, np.argmax(predictions, axis=1)))


# Plot the classifier
def plot_classifier(X, Y):
    # Load the model
    model = keras.models.load_model('./keras_nn.h5')
    # Plot model (Requires Graphviz)
    keras.utils.plot_model(model, show_shapes=True, rankdir='LR', expand_nested=True, to_file='./keras_nn_model.png')
    # Calculate
    h = 0.02
    x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))

    # Make predictions
    Z = model.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = np.argmax(Z, axis=1)
    Z = Z.reshape(xx.shape)
    # Plot diagram
    fig = plt.figure(figsize=(12, 8))
    plt.contourf(xx, yy, Z, cmap='ocean', alpha=0.25)
    plt.contour(xx, yy, Z, colors='w', linewidths=0.4)
    plt.scatter(X[:, 0], X[:, 1], c=Y, s=40, cmap='Spectral')
    plt.xlim(xx.min(), xx.max())
    plt.ylim(yy.min(), yy.max())
    plt.savefig('./keras_nn_classifier.png')


# The main entry point for this module
def main():
    #generate_spirals()
    # Load data set (includes header values)
    #dataset = pandas.read_csv('./spirals.csv')
    # Generate spirals
    #generate_spirals()
    data = './spambase.csv'
    # define dictionaty to map TRUE / FLASE string to bool
    dic = {
        'nonspam': 0,
        'spam': 1
    }

    dataset = pandas.read_csv(data)
    # this will replace "Boston Celtics" with "Omega Warrior"
    dataset = dataset.replace(dic)
    array = dataset.values

    # Visualize data set

    #visualize_data_set(data)

    # Slice data set in data and labels (2D-array)
    X = dataset.values[:, 0:57].astype(float)  # Data
    Y = dataset.values[:, 57].astype(bool)  # Labels

    #Y = dataset.values[:, 57].astype(int)  # Labels
    # Split data set in train and test (use random state to get the same split every time, and stratify to keep balance)
    X_train, X_test, Y_train, Y_test = sklearn.model_selection.train_test_split(X, Y, test_size=0.2, random_state=5,
                                                                                stratify=Y)
    # Make sure that data still is balanced
    print('\n--- Class balance ---')
    print(np.unique(Y_train, return_counts=True))
    print(np.unique(Y_test, return_counts=True))
    # Train and evaluate
    train_and_evaluate(X_train, Y_train, X_test, Y_test)
    # Plot classifier
    plot_classifier(X, Y)


# Tell python to run main method
if __name__ == "__main__": main()