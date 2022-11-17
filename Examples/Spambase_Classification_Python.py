#!/usr/bin/env python
# coding: utf-8

"""
Class for supervised classification using three ML algorithms
Source: Online and ML Mastery with Python
"""


# Load libraries
import numpy as np
from matplotlib import pyplot
from pandas import read_csv
from pandas import set_option
from pandas.plotting import scatter_matrix
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC
from sklearn.ensemble import AdaBoostClassifier
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import ExtraTreesClassifier
import seaborn as sns

# In[8]:


# Load dataset, Ensure your data is

url = './spambase.csv'

# In[9]:

# Read data from directory
dataset = read_csv(url)  # , skiprows=1

# In[10]:


# Display dimensions (shape)
print(dataset.shape)

# In[11]:


# Display features types
set_option('display.max_rows', 50)
print(dataset.dtypes)

# In[12]:


# View first 10 rows of each feature (head)
set_option('display.width', 110)
print(dataset.head(10))

# In[13]:


# Get statistic of data
print(dataset.describe())

# In[14]:


# See class distribution
print(dataset.groupby('type').size())

# In[15]:


# Display class distribution
sns.countplot(x='type', data=dataset)

# In[16]:


# histograms
dataset.hist(sharex=False, sharey=False, xlabelsize=0.5, ylabelsize=0.5)
pyplot.show()

# In[17]:


# density
dataset.plot(kind='density', subplots=True, layout=(8, 8), sharex=False, legend=False,
             fontsize=.01)
pyplot.show()

# In[18]:


# Heatmap for correlation matrix
sns.heatmap(dataset.corr(), cmap='coolwarm', annot=False)

# In[19]:


# Split-out validation dataset
array = dataset.values
# X is always all features
X = array[:, 0:57].astype(float)
# Y is always the target
Y = array[:, 57]
validation_size = 0.20
seed = 7
X_train, X_validation, Y_train, Y_validation = train_test_split(X, Y,
                                                                test_size=validation_size, random_state=seed)

# In[20]:


# Add multiple algorithm by adding name and the algorithm itself.
models = []
models.append(('KNN', KNeighborsClassifier()))
models.append(('NB', GaussianNB()))
models.append(('SVM', SVC(gamma='auto')))
results = []
names = []

# In[21]:

# Iterate through the list of models
for name, model in models:
    # Setup cross-validation
    kfold = KFold(n_splits=10, random_state=7, shuffle=True)
    # Get results of training the model
    cv_results = cross_val_score(model, X_train, Y_train, cv=kfold, scoring='accuracy')
    # Add results of training to the results list
    results.append(cv_results)
    names.append(name)
    # Display mean and std. of Accuracy
    msg = "%s: accuracy: %f accuracy std. (%f)" % (name, cv_results.mean(), cv_results.std())
    print(msg)

    # Fir the model using trainind data. Needed anytime you want to predict anything
    model.fit(X_train, Y_train)

    # Test the model using the testing (validation) data
    predictions = model.predict(X_validation)
    print("Accuracy Score ")
    print(accuracy_score(Y_validation, predictions))
    print("Confusion Matrix ")
    print(confusion_matrix(Y_validation, predictions))
    print("Classification report")
    print(classification_report(Y_validation, predictions))
    print("=======================================================")

# In[24]:


# Compare Algorithms
fig = pyplot.figure()
fig.suptitle('Algorithm Comparison')
ax = fig.add_subplot(111)
pyplot.boxplot(results)
ax.set_xticklabels(names)
pyplot.show()



