# cert-manager-example
cert-manager部署和使用示例(CA模式).

关于生成CA证书部分

为k8s中的服务生成证书，用来tls加密。常见有两种方式：

+ 一种是`openssl命令`为服务生成证书；
+ 另一种是是借助`cert-manager`自动为service生成证书；

这两者方式生成根证书的步骤都是一样的。`cert-manager`自动化的是通过CA为每个服务生成各自证书的过程。

```bash
# 共有部分

openssl genrsa -out ca.key 4096

openssl req -x509 -new -nodes -key ca.key -subj "/CN=icos.city" -days 3650 -reqexts v3_req -extensions v3_ca -out ca.crt
```

openssl 根据`CA`签发证书和私钥：

```bash
# 
openssl genrsa -out icos.city.key 4096

openssl req -new -sha256 -key icos.city.key -out icos.city.csr -subj "/CN=icos.city"

# icos.city.ini
# [ ext ]
# subjectAltName = @dns
# 
# [ dns ]
# DNS.1 = *.icos.city
openssl x509 -req -in icos.city.csr -CA ca.crt -CAkey ca.key -CAcreateserial -days 3560 -out icos.city.crt -extfile icos.city.ini -extensions ext

kubectl --kubeconfig=/home/hex/m1c2 create secret tls test-secret  --cert=icos.city.crt --key=icos.city.key -n mars
```

`cert-manager`将以上内容自动化，自动生成关于此服务的证书


# reference
关于grpc的内容，需要参考此链接

[grpc_github](https://github.com/grpc/grpc)
[grpc_go_quick_start](https://grpc.io/docs/languages/go/quickstart/)
[grpc python quick-start](https://grpc.io/docs/languages/python/quickstart/)
[grpc_java_quick-start](https://github.com/grpc/grpc-java)

[ingress-nginx-grpcExample](https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/grpc)
[ingress-nginx-grpc-DOC](https://kubernetes.github.io/ingress-nginx/examples/grpc/)
[ingress-nginx-grocExampleImage](https://github.com/kubernetes/ingress-nginx/tree/master/images/grpc-fortune-teller)

关于cert-manager的内容

[Automatic TLS certificates with cert-manager and ingress-nginx](https://atelierhsn.com/2020/07/cert-manager-ingress/)

