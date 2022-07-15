All custom code goes into this directory. All scripts should be written such that they can be executed from the root of
the dataset, and are only using relative paths for portability.

# Factor Analysis

The [Human Connectome Project Young Adult data set](https://www.humanconnectome.org/study/hcp-young-adult/article/announcing-1200-subject-data-release)
contains contains behavioral and magnetic resonance imaging (MRI) data from more than 1200 healthy young adults. Imaging
modalities include structural, resting state and diffusion MRI. The goal of our project is to relate structural and
functional connectivity data from MRI to behavior.

The behavioral data consist of a wide range of cognitive measures, as well as questionnaires on mood and personality
tests. As each of these measures is likely to be influenced by several psychological constructs, we are interested in
the latent structure of the behavioral measures. To this end, we
use [exploratory factor analysis](https://en.wikipedia.org/wiki/Factor_analysis) (EFA) to discover the latent variables
that cause the expression of the behavioral variables. These latent factors represent behavioral domains that can then
be related to brain connectivity data derived from functional, structural, and diffusion MRI (fMRI, sMRI, dMRI) data.
Additionally, confirmatory factor analysis (CFA) will be used on all subjects without scanner data to test the presumed
latent structure in a separate notebook.