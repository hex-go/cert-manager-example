#!/usr/bin/env bash
grpcurl -insecure test.icos.city:443 build.stack.fortune.FortuneTeller/Predict
grpcurl -insecure icossec-svc.mars.service.rd:443 build.stack.fortune.FortuneTeller/Predict
