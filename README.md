# INFO201 Final Group Project Proposal

![Cancer](https://www.wraltechwire.com/wp-content/uploads/2018/04/cancer.jpg)
###### Copyright WRAL TechWire

## Author:
- "Kaz Jiang"
- "Xiying(Nina) Zhang"
- "Yue(Ivy) Wu"
- "Bingyan Wang"

## Project description:
The dataset we will be working with is the **U.S. Cancer Statistics** from **1999** to **2015**, collecting information about all available _diagnosed cancer cases_ and _deaths_ for the **whole U.S. population**. This U.S. Cancer Statistics(_USCS_) is collected by **Centers for Disease Control and Prevention(_CDC_)**. We will use this dataset to build some visualizations and look for the possible _tendencies_ between cancer and other factors like **geographical locations, genders, races and ages**, etc.\
Our target **audiences** could be professional public health staff, as well as people who are interested in cancer statistics or _suspicious_ about their own health condition. The **latter** one is the audience we put _more_ focuses on, since our goal is to enable the general public to figure out their own propensity of cancer dangers. 

* Possible questions answer for audience:
    + How could cancer rate be possibly affected by different states, genders, rates, or other individuals’ factors?
    + Which cancer type is the most prevalence one in U.S? Are there differences in different state/area?
    + Does cancer mortality show any differences between male and female?

## Technical Description
- In the final project we will use both _API_ and _csv_ in order to achieve our goal.  From API, we will use `httr` and `jsonlite` libraries to parse the _JSON data_ from api to a R data frame. From .csv, we will just use basic read.csv function to parse the data.
- We will separate dataset to **two major groups** (_mortality_ and _incident_) then sort the data in order to make _visualize_ easier. Also, we will filter out the NA value in order to make dataset valid. Additionally, we will probably modify both API data and csv data in order to make a join.
- This time we will focus on libraries: `shiny`, `httr`, `jsonlite`, `ploty`, and maybe some other libraries which will make the **visualization** more efficient.
- The major **challenges**: Make a well format dataset to work with because most of cancer dataset are badly formatted. Make a beautiful visualization and also easy for client to understand. Make an **attractive R based website**.
