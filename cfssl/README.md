# Usage

```(shell)
# Pull the image from dockerhub repo
docker pull praveenc/cfssl

# Create a folder for your cert generation
mkdir -p mycerts
cd mycerts

# Launch the container mounting mycerts folder as a volume
docker run -it --rm -d \
    --name mycfssl \
    -v $(pwd):/root
    praveenc/cfssl

# Create an alias pointing to cfssl in the running container
alias cfssl="docker exec -it mycfssl cfssl"

# Create csr.json file 
touch ca-csr.json

# Write a sample ca-csr.json
cat <<- EOF > ca-csr.json
{
  "hosts": [
    "cluster.local"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Oregon"
    }
  ]
}
EOF

# now you can use cfssl to create a certificate authority
$ cfssl gencert -initca /root/ca-csr.json

2018/11/12 15:25:53 [INFO] generating a new CA key and certificate from CSR
2018/11/12 15:25:53 [INFO] generate received request
2018/11/12 15:25:53 [INFO] received CSR
2018/11/12 15:25:53 [INFO] generating key: rsa-2048
2018/11/12 15:25:53 [INFO] encoded CSR
2018/11/12 15:25:53 [INFO] signed certificate with serial number 554677386586828163619707749520789400770353638778
{"cert":"-----BEGIN CERTIFICATE-----\nMIIDdjCCAl6gAwIBAgIUYSiYICd6uo3PcRDa66HAUS6ZLXowDQYJKoZIhvcNAQEL\nBQAwUzELMAkGA1UEBhMCVVMxDzANBgNVBAgTBk9yZWdvbjERMA8GA1UEBxMIUG9y\ndGxhbmQxEzARBgNVBAoTCkt1YmVybmV0ZXMxCzAJBgNVBAsTAkNBMB4XDTE4MTEx\nMjE1MjEwMFoXDTIzMTExMTE1MjEwMFowUzELMAkGA1UEBhMCVVMxDzANBgNVBAgT\nBk9yZWdvbjERMA8GA1UEBxMIUG9ydGxhbmQxEzARBgNVBAoTCkt1YmVybmV0ZXMx\nCzAJBgNVBAsTAkNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA89Uh\nY7bpp/pfHwYEBYfEdCu86cKKVLbJaiIBCXm5kZLG5gz7E6mhCG+1dgWayhtCuIMZ\nO7S/xJmyJUsfVTxcgBxEN2Sanj64+N5pzzgA7ioHmho5vmapJC++dF3JN6SbT7SY\nRAVSH+looCg25CcHNoCYz939HNmqWDG8CIXyMBesjoQb5TiGXTM9kbwfAzaTfmsp\niTyLSNBuFn0udtGxIm54gvOMCbizpYw9jV8fnLO+Jw5IRGFL4H1MnkWYNweeccHJ\nSYqDkBfte/L5iwCV0j0/rzfnMFfsaTIusyX6g7Gb1tDInOw+sPvjMHFYRaIS3EHt\nlcaCcUdal6EKxFcI/QIDAQABo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/\nBAUwAwEB/zAdBgNVHQ4EFgQUx2eReVfOjM/Es3VTbEXB/r1ZB6kwDQYJKoZIhvcN\nAQELBQADggEBAFmRAmm/K5/tFuBFTxCnJCYzrsEcR5DmEPhk5SAa5AYrkh6zVC/Z\n3HfKcnCnTemjq7o3fV203mAwonQVnS5Cd3jL21qlsJY8b9h1ROJzxTWW9eXqVGW8\nnKyQUhyRmtBW5xzkyiCcLBAmqKyCJkGx4RXfO4sEL1nUwM6adETPdlFsaKzNsPlY\nsh/GJK6MV+yVqMzsPes57ceG5SAM+DLrD+oCeqfEPds9keCUxsetXA5CDsd2+ddM\npXyiGHUgqV6smAMME5/FEqoso0WC8JTVMsZNPm7kJU3lxLybXZggTxp4Kz1v7H1J\n+Xtd9vnX92IqLk6CUBHqnQbOQAweqPLd6Jg=\n-----END CERTIFICATE-----\n","csr":"-----BEGIN CERTIFICATE REQUEST-----\nMIICwzCCAasCAQAwUzELMAkGA1UEBhMCVVMxDzANBgNVBAgTBk9yZWdvbjERMA8G\nA1UEBxMIUG9ydGxhbmQxEzARBgNVBAoTCkt1YmVybmV0ZXMxCzAJBgNVBAsTAkNB\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA89UhY7bpp/pfHwYEBYfE\ndCu86cKKVLbJaiIBCXm5kZLG5gz7E6mhCG+1dgWayhtCuIMZO7S/xJmyJUsfVTxc\ngBxEN2Sanj64+N5pzzgA7ioHmho5vmapJC++dF3JN6SbT7SYRAVSH+looCg25CcH\nNoCYz939HNmqWDG8CIXyMBesjoQb5TiGXTM9kbwfAzaTfmspiTyLSNBuFn0udtGx\nIm54gvOMCbizpYw9jV8fnLO+Jw5IRGFL4H1MnkWYNweeccHJSYqDkBfte/L5iwCV\n0j0/rzfnMFfsaTIusyX6g7Gb1tDInOw+sPvjMHFYRaIS3EHtlcaCcUdal6EKxFcI\n/QIDAQABoCswKQYJKoZIhvcNAQkOMRwwGjAYBgNVHREEETAPgg1jbHVzdGVyLmxv\nY2FsMA0GCSqGSIb3DQEBCwUAA4IBAQBq0AeLKnTGz74ftrZCj8NcEkvL1k8Eey9t\ngFnVM/b0au61ie1Aizt8+urm+QVXQBWX/UeAYuhZ7m/gIbY554l03bgUC5XkOBvC\n9CbhbZjmRgH+JhB6r7sI2SgBlWoNKXHZk3mDBBFE3YWb/k13rPZlGfs3e0bhG7cr\notwiPTQOF5OoVMNWSjZIKVTKVFWDNoC5mQGm2fYHB3SbGOckAqZ6hPkWqg1qYM5/\nmv+izNgOODroVKwyJU8y1uRKoRDE6i9LHAUyep044u9Z7FQss66AxrwiFjSgyINR\nUYrsgrQhPcQ27/clq4sgvwlnzYsP4apiwpoEtALjHAOmCH8bxOen\n-----END CERTIFICATE REQUEST-----\n","key":"-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEA89UhY7bpp/pfHwYEBYfEdCu86cKKVLbJaiIBCXm5kZLG5gz7\nE6mhCG+1dgWayhtCuIMZO7S/xJmyJUsfVTxcgBxEN2Sanj64+N5pzzgA7ioHmho5\nvmapJC++dF3JN6SbT7SYRAVSH+looCg25CcHNoCYz939HNmqWDG8CIXyMBesjoQb\n5TiGXTM9kbwfAzaTfmspiTyLSNBuFn0udtGxIm54gvOMCbizpYw9jV8fnLO+Jw5I\nRGFL4H1MnkWYNweeccHJSYqDkBfte/L5iwCV0j0/rzfnMFfsaTIusyX6g7Gb1tDI\nnOw+sPvjMHFYRaIS3EHtlcaCcUdal6EKxFcI/QIDAQABAoIBAQC9Ih4TLaeSb4fn\nFZB7BbPh9KdFn2wTh/E1zQiG5A+IFpUHjxwWRWaul4/m6zQE/x5C5xXklTCG/D0N\n5nZ4dCjACqzzVqsEglySVls2rBc0pg9dfmg6A4HBmvMdaj4RVjJOoiPV51argC5y\nxJ7HXGqg4SEnY+bYwRH79SAIcHXKzJ6fnm2wKUnFHFZToqs7esPP0Qywm56VlI9v\nRniti3TNyVx3HAiX+mwVlWFRx/aVs9wn9BJ1J5jXjUhg0xTybOJ41yALObS1W/+u\niXMtyEsK1H2lI5qiQppNq8h+Lyfy3o5Cze/svqJILh+qpzH90HuL/ccdkFe0d8QW\nTKL2iuLVAoGBAPZirk/bHeRNHRrUpX8BXXhU8VJf8qpK+AvHhd+JDhFYHo/xZHTF\nyez82xmwQjtUYPL1Xptr3tGYUl0wBRqFXJMYuwd1O2VAM06yHxO8onQkAsmgZmV1\nKVFFZBhJpCDi75tbDeFKQwOIUK9PI+cb9id6hr593HEqY5fcGW9ZjCo3AoGBAP1Y\n8kx2R8PgfJGZXRz6NWhcBFXTczpJg5MIGKa4M57wIDowJuy9/ifEJTVAetWo8es3\n46nrMpfbZEJgXuOK5H6QxVOGt5fxoKPz2LvLpBIvOvenUwgBCz23rcQtEXAlVyjZ\ncr+gYeCVhxxy/JzS8N6DPQoFvhPZ6RIc9KShx7xrAoGAGbzJNLJQ9w5PIgRgnVnJ\nJ87HvrEjKkLWknRvOaCZhZpM5wByW/hlVYo8YPyWjpgL4JVdIqMsDXz57Z4cil6w\nAvWsY+UNJVCFi4zzzh4AYl14pRNKXwLUJBc5k4ftyzmpifMDCiu1wGK2+vkraPL0\nzb7w4GlJY9Dnwm9NgOI70BUCgYEA3FiIJMibElok/d2Nhq531RRzENKf3Yoizba0\n+gwrmYjv/qvyruVwL9YBJpe2Pi56ekJZ2Gef0UQXp0N6RB2BLjNr7IG3HIgjV3W2\ng19SjB5YAx2csdF2nW8ryvwHtqpDbFvz2Yb8mgBzSuMXoq40oNM0O4tTDqDwfbiB\nbs7mkZECgYEArL7xscwIVixNPLfI12YMjuH5XtME1ZoEZFEhkqgDFO4lYz/3Yeh7\nXxVAxBI29zqTiLja63MefovddfUhuzcNqIx6fjzgdGZ12tje+USzPCpZMGf/i/OT\nNh40X91CkjpMiuT5llUbc9SibxRnj4xqUQBRjUEg2jv67S7+a+D6N24=\n-----END RSA PRIVATE KEY-----\n"}
```
