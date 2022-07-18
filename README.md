# Exploring the Latent Structure of Behavior Using the Human Connectome Project’s Data

This is the repository to store the analysis code for the paper "Exploring the Latent Structure of Behavior Using the Human Connectome Project’s Data".

## System Requirements

To install the required packages and run the code, you need to have a working Python installation with [Anaconda](https://www.anaconda.com/) and Git installed. It should work on any operating system, but has only been tested on Ubuntu 20.04.4 LTS.

## Installation

### Get the code

Run in a terminal:

`git clone https://github.com/connectomicslab/hcp-behavioral-domains.git`

### Install the Conda Environment

From the folder you installed this repository in, you can run this to install the conda environment from the `environment.yml` file:

`conda env create -f environment.yml`

Then activate it via

`conda activate hcp-behavioral-domains`

## Generate Factor Scores

To generate the factor scores and loadings yourself you can use the `pipeline.py` script. This will call the exploratory factor analysis pipeline as described in the paper, including preprocessing. It will output the factor scores and loadings.

You need to provide the path to the unrestricted and the restricted behavioral data, as well as a list of the subject IDs you want to process and an output directory. You need to call it from the root directory of this repository:

`python pipeline.py /path/to/unrestricted/hcp_behavioral.csv /path/to/restricted/hcp_behavioral_RESTRICTED.csv /path/to/subjects/subject_IDs.csv /path/to/output/directory`

The script expects the subject IDs to be separated by returns, in one column. The HCP behavioral data can be used as they come when downloaded from [ConnectomeDB](https://db.humanconnectome.org/).
