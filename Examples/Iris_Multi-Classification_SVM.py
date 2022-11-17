"""
Python implementation of supervised ML classification of iris in iris dataset
"""
# import libraries
# installation might be needed if these are not available.
from sklearn import svm, datasets
import matplotlib.pyplot as plt
import numpy as np
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay


# Keep this as is
def main():
    """
    Main screen for the web scrapping file
    :return:
    """
    # Load the data
    iris = datasets.load_iris()
    print('iris dataset: \n')
    print(iris)

    # Set the features vectors to the first two only
    X = iris.data[:, :2]  # we only take the first two features

    print('Values of X:\n')
    print(X)

    # Set target, what are you trying to classify/ predict.
    y = iris.target
    print('Values of y:\n')
    print(y)

    # Default training and testing procedure.
    # Set testing dataset to 25% of the entire dataset
    x_train, x_test, y_train, y_test = train_test_split(X, y, random_state=0, test_size=0.25)

    # Call the SVM classifier and train on training data and training target
    clf = svm.SVC(kernel='linear', C=1).fit(x_train, y_train)

    # Test teh mode by predicting the testing dataset
    classifier_predictions = clf.predict(x_test)
    print("Model Accuracy\n")

    # Get Accuracy
    print(accuracy_score(y_test, classifier_predictions) * 100)

    # Get confusion Matrix
    cm = confusion_matrix(y_test, classifier_predictions, labels=clf.classes_)
    print(cm)
    disp = ConfusionMatrixDisplay(confusion_matrix=cm,display_labels = clf.classes_)
    disp.plot()
    plt.show()
    #
    # h = 0.02
    # x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    # y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    #
    # xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
    #                      np.arange(y_min, y_max, h))
    # xx.shape
    #
    # Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
    # Z = Z.reshape(xx.shape)
    # plt.contourf(xx, yy, Z, cmap=plt.cm.coolwarm, alpha=0.3)
    #
    # plt.scatter(X[:, 0], X[:, 1], c=y, cmap=plt.cm.coolwarm)
    # plt.xlabel('Sepal length')
    # plt.ylabel('Sepal width')
    # plt.xlim(xx.min(), xx.max())
    # plt.ylim(yy.min(), yy.max())
    # plt.xticks(())
    # plt.yticks(())
    # plt.title("Linear")
    # plt.show()


# Keep this is as
if __name__ == "__main__":
    main()
