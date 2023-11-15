FROM jdkato/vale:v2.29.0

COPY vale.ini /vale.ini
COPY vale-styles /vale-styles
COPY source /source
RUN vale source/*.*