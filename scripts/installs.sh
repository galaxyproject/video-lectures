conda install -y r-essentials nodejs pandoc
conda install -y -c conda-forge ffmpeg weasyprint
pip install weasyprint


npm install yarn
yarn add jake
yarn add rake

## For Jekyll use
# conda install -y ruby
# gem install --user-install bundler jekyll
##

## For Marp use
# npm install -g @marp-team/marp-cli
##

R -e "install.packages('ari', repos='http://cran.rstudio.com/')"
R -e "install.packages('aws.polly', repos='http://cran.rstudio.com/')"
R -e "install.packages('docopt', repos='http://cran.rstudio.com/')"
