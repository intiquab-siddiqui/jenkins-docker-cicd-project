# 🚀 Jenkins-Docker-CI/CD-Project

A hands-on DevOps project demonstrating an automated CI/CD pipeline for a Python Flask web application using **GitHub, Jenkins, Docker, and AWS EC2**.

The project starts with a simple Flask application and builds a complete automated deployment workflow where a GitHub push triggers Jenkins through a webhook. Jenkins then builds a Docker image, replaces the existing container, and deploys the latest version of the application.

---

## 📌 Project Overview

This project demonstrates how source code can move from a developer's GitHub repository to a running production-style container automatically.

### CI/CD Flow

```text
Developer
    |
    | git push
    v
GitHub Repository
    |
    | GitHub Webhook
    v
Jenkins
    |
    | Checkout
    v
Source Code
    |
    | Docker Build
    v
Docker Image
    |
    | Remove Old Container
    v
New Docker Container
    |
    v
Flask Application
    |
    | Port 5000
    v
Web Browser


🏗️ Architecture

                    ┌──────────────────────┐
                    │      Developer       │
                    │      EC2 / Git      │
                    └──────────┬───────────┘
                               │
                           git push
                               │
                               ▼
                    ┌──────────────────────┐
                    │       GitHub         │
                    │      main branch     │
                    └──────────┬───────────┘
                               │
                         Webhook Trigger
                               │
                               ▼
                    ┌──────────────────────┐
                    │       Jenkins        │
                    │   Jenkins Pipeline   │
                    └──────────┬───────────┘
                               │
                     ┌─────────┴─────────┐
                     │                   │
                     ▼                   ▼
                Docker Build       Docker Deploy
                     │                   │
                     └─────────┬─────────┘
                               ▼
                    ┌──────────────────────┐
                    │   Docker Container   │
                    │      Flask App       │
                    │      Port 5000       │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │     Web Browser      │
                    │   Application v3     │
                    └──────────────────────┘


🛠️ Technologies Used
Technology	Purpose
AWS EC2	Linux server / infrastructure
Ubuntu	Operating system
Git	Version control
GitHub	Source code repository
Python	Application programming language
Flask	Web application framework
Docker	Application containerization
Jenkins	CI/CD automation
GitHub Webhook	Automatic Jenkins triggering
Bash/Linux Commands	Server administration and troubleshooting
📂 Project Structure
jenkins-docker-cicd-project/
│
├── app.py
├── requirements.txt
├── Dockerfile
├── Jenkinsfile
├── .gitignore
└── README.md
File Description
app.py

Main Flask application.

The application exposes the / endpoint and returns:

Jenkins CI/CD Project v3 is Running!

The Flask application listens on:

0.0.0.0:5000
requirements.txt

Contains the Python dependencies required by the Flask application.

Example dependencies:

Flask==3.1.3
Werkzeug==3.1.8
Jinja2==3.1.6

Dependencies are installed automatically while building the Docker image.

Dockerfile

Used to create the Docker image.

FROM python:3.14-slim


WORKDIR /app


COPY requirements.txt .


RUN pip install --no-cache-dir -r requirements.txt


COPY app.py .


EXPOSE 5000


CMD ["python", "app.py"]
Dockerfile Explanation
FROM

Uses the lightweight Python 3.14 image.

WORKDIR

Creates /app as the working directory inside the container.

COPY requirements.txt

Copies Python dependencies into the container.

RUN pip install

Installs Flask and other required packages.

COPY app.py

Copies the Flask application into the container.

EXPOSE 5000

Documents the port used by the application.

CMD

Starts the Flask application when the container starts.

🔄 Jenkins CI/CD Pipeline

The Jenkins pipeline is defined in:

Jenkinsfile

Current pipeline:

pipeline {


    agent any


    stages {


        stage('checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/intiquab-siddiqui/jenkins-docker-cicd-project.git'
            }
        }


        stage('Docker build') {
            steps {
                sh 'docker build -t jenkins-docker-cicd-app .'
            }
        }


        stage('docker run') {
            steps {
                sh 'docker rm -f jenkins-docker-cicd-container || true'
                sh 'docker run -d -p 5000:5000 --name jenkins-docker-cicd-container jenkins-docker-cicd-app:latest'
            }
        }
    }
}
🔧 Pipeline Stages
1. Checkout

Jenkins retrieves the latest source code from the main branch.

git branch: 'main',
    url: 'https://github.com/intiquab-siddiqui/jenkins-docker-cicd-project.git'
2. Docker Build

Jenkins builds a new Docker image:

docker build -t jenkins-docker-cicd-app .

The Dockerfile is used to:

Create the Python environment
Install dependencies
Copy application code
Prepare the Flask application
3. Docker Deployment

Jenkins removes the existing container:

docker rm -f jenkins-docker-cicd-container || true

The || true prevents the pipeline from failing if the container does not already exist.

Jenkins then starts a new container:

docker run -d \
-p 5000:5000 \
--name jenkins-docker-cicd-container \
jenkins-docker-cicd-app:latest
🔗 GitHub Webhook Integration

GitHub Webhook was configured to automatically trigger Jenkins whenever code is pushed to the repository.

Webhook Endpoint
http://<EC2-PUBLIC-IP>:8080/github-webhook/
Jenkins Trigger

The Jenkins job uses:

GitHub hook trigger for GITScm polling
Webhook Verification

GitHub webhook delivery returned:

HTTP 200

This confirmed that GitHub could successfully communicate with Jenkins.

🚀 Automatic CI/CD Workflow

After webhook configuration, the workflow became:

1. Developer changes application
        ↓
2. git add
        ↓
3. git commit
        ↓
4. git push origin main
        ↓
5. GitHub receives commit
        ↓
6. GitHub sends webhook
        ↓
7. Jenkins automatically starts
        ↓
8. Jenkins checks out latest code
        ↓
9. Docker image is rebuilt
        ↓
10. Existing container is removed
        ↓
11. New container is started
        ↓
12. Updated application becomes available
🧪 Testing and Verification

The application was tested at multiple stages.

Test Flask Application
python app.py

Test:

curl http://localhost:5000

Expected:

Jenkins CI/CD Project is Running!
Test Docker Container

Check running containers:

docker ps

Test application:

curl http://localhost:5000

Expected:

Jenkins CI/CD Project is Running!
Browser Test

The deployed application was accessed using:

http://<EC2-PUBLIC-IP>:5000

Final application output:

Jenkins CI/CD Project v3 is Running!
🐳 Docker Commands Used
Check Docker version
docker --version
List running containers
docker ps
List all Docker images
docker images
Build image
docker build -t jenkins-docker-cicd-app .
Run container
docker run -d -p 5000:5000 \
--name jenkins-docker-cicd-container \
jenkins-docker-cicd-app:latest
Remove container
docker rm -f jenkins-docker-cicd-container
Test application
curl http://localhost:5000
🐧 Linux Troubleshooting Commands

The project was developed and tested on an Ubuntu EC2 instance.

Check current directory
pwd
List files
ls
Check Git status
git status
Check running processes
ps aux
Search for Flask process
ps aux | grep "python app.py"
Check network ports
ss -tuln
Test local connectivity
curl http://localhost:5000
🔧 Troubleshooting Performed
1. Flask was not installed

Initial test:

python3 -c "import flask; print(flask.__version__)"

Result:

ModuleNotFoundError: No module named 'flask'
Solution

Created a Python virtual environment:

python3 -m venv venv

Activated it:

source venv/bin/activate

Installed Flask:

pip install flask
2. Flask Application Was Not Running

Testing:

curl http://localhost:5000

Returned:

curl: (7) Failed to connect to localhost port 5000

The Flask process was checked using:

ps aux | grep "python app.py"

The application was restarted:

python app.py

After restarting, the application responded successfully.

3. Docker Container Verification

Running containers were checked using:

docker ps

Application connectivity was verified using:

curl http://localhost:5000
4. Jenkins Docker Deployment

The Jenkins pipeline was configured to remove the previous container before starting the new one:

docker rm -f jenkins-docker-cicd-container || true

This prevents container-name conflicts during repeated deployments.

5. Git Branch Management

The initial repository was created using the default master branch.

The branch was renamed to:

git branch -M main

The project was then pushed to:

origin/main
🔐 Git Configuration

The following files are excluded using .gitignore:

venv/
__pycache__/
*.pyc

This prevents the Python virtual environment and Python cache files from being committed to GitHub.

📈 CI/CD Demonstration

The pipeline was tested by updating the Flask application multiple times.

Version 1
Jenkins CI/CD Project is Running!
Version 2
Jenkins CI/CD Project v2 is Running!
Version 3
Jenkins CI/CD Project v3 is Running!

The version 3 update demonstrated the complete automated workflow:

Code Change
    ↓
Git Commit
    ↓
Git Push
    ↓
GitHub Webhook
    ↓
Jenkins Automatically Triggered
    ↓
Docker Image Rebuilt
    ↓
Old Container Removed
    ↓
New Container Deployed
    ↓
Version 3 Available in Browser
📊 Project Results

The project successfully achieved:

✅ Flask application deployment
✅ Docker containerization
✅ Docker image creation
✅ Jenkins declarative pipeline
✅ GitHub integration
✅ GitHub Webhook integration
✅ Automatic Jenkins triggering
✅ Automated Docker image build
✅ Automated container deployment
✅ Application version update through CI/CD
✅ Browser-based application verification
🎯 Learning Outcomes

Through this project, the following DevOps concepts were practiced:

Git
Repository initialization
Git status
Git add
Git commit
Git branch
Git remote
Git push
Branch management
Linux
Directory navigation
File creation
Process management
Network testing
Application troubleshooting
Docker
Docker images
Docker containers
Dockerfile
Image building
Port mapping
Container lifecycle
Container replacement
Jenkins
Jenkins Pipeline
Declarative Pipeline syntax
Pipeline stages
Jenkinsfile
SCM checkout
Shell commands
Automated Docker deployment
CI/CD
GitHub integration
Webhooks
Automated builds
Automated deployments
Continuous integration
Continuous delivery/deployment workflow
💼 Interview Explanation

If asked to explain this project in an interview:

I built an automated CI/CD pipeline for a Python Flask application using GitHub, Jenkins, Docker, and AWS EC2. I containerized the Flask application using a Dockerfile and created a Jenkins declarative pipeline with stages for source code checkout, Docker image building, and container deployment. I configured a GitHub Webhook so every push to the main branch automatically triggers Jenkins. Jenkins builds a new Docker image, removes the previous container, and starts a new container with the latest application version. I validated the deployment using curl and by accessing the application through the EC2 public IP in a web browser.

🔮 Future Improvements

The current project provides a basic CI/CD implementation. Future improvements could include:

Add automated application tests
Add Docker image tagging using Git commit IDs
Push images to Docker Hub or Amazon ECR
Add Jenkins credentials management
Add SonarQube code-quality scanning
Add Trivy container vulnerability scanning
Add deployment to Kubernetes
Add Nginx reverse proxy
Add HTTPS using a domain and SSL certificate
Add monitoring using Prometheus and Grafana
Add rollback strategy
Add separate development and production environments
👨‍💻 Author

Intiquab Siddiqui

Aspiring DevOps Engineer

Technologies practiced:

Linux | Git | GitHub | Docker | Jenkins | Python | Flask | AWS
⭐ Project Status
STATUS: COMPLETED ✅


GitHub → Jenkins → Docker → Flask


Automated CI/CD Pipeline: WORKING 🚀
GitHub Webhook: WORKING ✅
Docker Deployment: WORKING ✅
Browser Application: WORKING ✅


