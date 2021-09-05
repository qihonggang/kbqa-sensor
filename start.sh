#!/bin/bash

rm -f ./jena/tdb/*
/kbqa/jena/apache-jena-3.5.0/bin/tdbloader --loc="/kbqa/jena/tdb" "/kbqa/sensor_situation.nt"
streamlit run /kbqa/streamlit_app.py --server.enableCORS=true &
cd /kbqa/jena/apache-jena-fuseki-3.5.0 || return
./fuseki-server