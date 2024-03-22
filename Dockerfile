# Tony
FROM ubuntu:jammy
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq install python3-pip

COPY requirements.txt /model/
RUN pip3 install -r /model/requirements.txt


COPY handler/aki_detector.py /model/handler/
COPY aki_model.json /model/
COPY aki.csv /model/
COPY app.py /model/
COPY handler/data_processor.py /model/handler/
COPY data/history.csv /model/data/
COPY handler/hl7_processor.py /model/handler/
COPY handler/listener.py /model/handler/
COPY handler/pager.py /model/handler/
COPY utils/f3_evaluation.py /model/utils/
COPY config/metrics.py /model/config/

RUN chmod +x /model/app.py
EXPOSE 8440
EXPOSE 8441
EXPOSE 8000

CMD /model/app.py --mllp=$MLLP_ADDRESS --pager=$PAGER_ADDRESS --local=False