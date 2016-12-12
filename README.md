[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.200259.svg)](https://doi.org/10.5281/zenodo.200259)
# IDC-Assignment
Code developed for the assignment of the course PCS5031 - Introduction to Data Science, at the University of São Paulo

This repository contains all the R scripts we used for our analysis on the Yelp datasets. Yelp makes these datasets available and free to use (under certain conditions) for their yearly challenge (https://www.yelp.com.br/dataset_challenge).

Our main goal was to determine which city was the most promising to invest in a new vegan restaurant.



"loading.r" creates the whatever rds file you need to get going. You must first pick one dataset ("review, business, checkin, tip or user?") and then choose the attributes you want to keep in your rds file ("Insert the attribute names you want, as above and separated by space:").

"vegan.r" is used to generate two smaller datasets, "vegan_data" (all the user classiifed as vegan or, at least, as having some intest about vegan restaurantes) and "vegan_businesses" (vegan restaurants), to carry out our analysis. Please note that this we used a quick and relatively imprecise classifying method. We encourage you to contribute with this repository with your own and more precise algorithms for indentifying groups of users.

"analysis.r" is a template for generating graphs using the data available in the two aforementioned datasets. By standart, it generates a dot chart and histograms for 5 cities. We chose this 5 cities because they are the one with the largest number of vegan businesses.
