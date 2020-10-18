# Segmentation Speed Benchmark
Utility scripts for benchmarking Thai segmenters on a cloud server (AWS). We use `Terraform` to boostrap the server.

## Requirements
- Terraform CLI
- AWS CLI

## Boostraping the testing server
```
$ terraform plan
$ terraform apply
$ terraform destroy
```

## Running benchmarks
```
$ ./scripts/run-experiments [wisesight.txt|best-val.txt]
```
