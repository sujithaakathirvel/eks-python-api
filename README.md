# EKS Python API — Kubernetes on AWS

A production-style Python API deployed on **Amazon EKS** using Terraform, Docker, Kubernetes, and the AWS Load Balancer Controller.

---

## Architecture

```text
Client
  ↓
AWS Application Load Balancer
  ↓
Kubernetes Ingress
  ↓
Kubernetes Service
  ↓
EKS Pods
```

- **Amazon EKS** — managed Kubernetes cluster
- **EC2 / t3.small** — worker nodes
- **AWS Application Load Balancer** — internet-facing load balancer
- **AWS Load Balancer Controller** — provisions and manages the ALB
- **Amazon ECR** — container image registry
- **Terraform** — Infrastructure as Code
- **Docker** — containerisation
- **Kubernetes** — deployment, service, ingress and self-healing
- **JMeter** — performance testing

---

## Key Implementation

- Provisioned the EKS cluster and networking using Terraform
- Deployed a containerised Python API to Kubernetes
- Configured Kubernetes readiness and liveness probes
- Configured an internet-facing AWS ALB through Kubernetes Ingress
- Used 2 worker nodes across separate Availability Zones
- Tested Kubernetes self-healing by deliberately deleting a running pod
- Compared API performance using 2 and 4 replicas

---

## Performance Results

JMeter test configuration:

- **50 concurrent users**
- **30-second ramp-up**
- **60-second test duration**
- `GET /health`
- Identical test configuration for both runs

| Replicas | Requests | Throughput | Avg Latency | Errors |
|---:|---:|---:|---:|---:|
| 2 | 98,415 | 1,637.9 req/s | 22 ms | 0% |
| 4 | 169,103 | 2,814.8 req/s | 13 ms | 0% |

Scaling from **2 → 4 replicas** produced approximately:

- **72% higher throughput**
- **41% lower average latency**
- **0% errors in both tests**

---

## Self-Healing Test

A running API pod was deliberately deleted to simulate a failure.

Kubernetes automatically:

1. Detected the missing replica
2. Created a replacement pod
3. Scheduled the replacement
4. Started the container
5. Restored the deployment to **2/2 healthy replicas**

**Observed recovery interval:** ~226 seconds.

No manual redeployment or scaling was required.

---

## Evidence

Experiment evidence is stored under:

```text
results/
├── jmeter/
│   └── health-test.jmx
└── terminal/
    ├── 2-replica-baseline.txt
    ├── 4-replica-baseline.txt
    ├── self-healing-before.txt
    ├── self-healing-after.txt
    └── self-healing-events.txt
```

The JMeter test plan and captured terminal evidence document the performance and self-healing experiments.

---

## Technologies

`AWS` `EKS` `EC2` `ALB` `ECR` `IAM` `Terraform` `Kubernetes` `Docker` `Python` `JMeter` `Helm`
