#!/bin/bash

echo "Installation of ICR142_Benchmarking is running ..."

[ -w ".Rprofile" ] && rm .Rprofile

Rscript sessionInfo.R --bootstrap-packrat > setup.log 2>&1

cp packrat/packrat_source/.Rprofile ./

echo "Installation of ICR142_Benchmarking has finished ..."
