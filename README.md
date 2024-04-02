

**Step 5** (Master Jenkin) Installation of Maven , install maven on Jenkin Plugin + define Maven under tools maven tab as well with name as M3 other way if maven need to install manually on Jenkin server then we need to follow   https://www.digitalocean.com/community/tutorials/install-maven-linux-ubuntu

**Step 6**: (Setup Jenkin Slave agent which has Docker configured) 
       - Important Point Jenkin server Listen from 32768 to 60999 as assigned to Jenkins for connecting with Docker containers, if need to connect to jenkin Agent node we need to manually define speific Port under security & open at firewall level.
       - Docker Remote API uses port 4243
       - In order Jenkin to communicate with Docker user please add docker user to docker group adim & reboot machine , reference https://stackoverflow.com/questions/47854463/docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socke
          # sudo usermod -a -G docker $USER
          # reboot 
This method where we can have master Jenkin + Slave agents & slave agents can perfom build & deploy 


Stage 2 : mvn Build
Stage 3: docker image build
Stage 4: docker container validation & termination
Stage 5 : container setup on docker 
Stage 6: push image to docker repository
Stage 7: docker logout 

code till this stage 

===========
pipeline {
    agent {
      label 'slave'    
    }
    tools{
        // Install the Maven version configured as "M3" and add it to the path.
        maven 'M3'
    }

    stages {
        stage(printmessagefortesting) {
            steps {
               echo 'hello world'
            }
        }
        stage(Gitclone) {
            steps {
              git 'https://github.com/puneetchopra2022/CICD-Project-1.git'
            }
        }
        stage(mvnbuild) {
            steps {
                sh 'mvn clean package'
            }
        
        }
        stage(dockerbuild) {
            steps {
              sh 'docker build -t tomcatimage .'    
            }
        }
        stage(containerrun) {
                steps {
                sh 'docker stop tomcatserver'  
                sh 'docker rm tomcatserver'
                sh "docker run -dt -p 9090:8080 --name tomcatserver tomcatimage"
                    
                }    
        }
        
    }

}
========
following this https://thetechdarts.com/deploy-to-dockerhub-using-jenkins-declarative-pipeline/ 
Now **Stage 7** docker login
**Stage 8** push docker image to docker Hub 
**stage9: logout

pipeline {
    agent {
      label 'slave'    
    }
    tools{
        // Install the Maven version configured as "M3" and add it to the path.
        maven 'M3'
    }
    environment {
        DOCKERHUB_CREDENTIALS= credentials('dockerpushcredentials') 
    }

    stages {
        stage(printmessagefortesting) {
            steps {
               echo 'hello world'
            }
        }
        stage(Gitclone) {
            steps {
              git 'https://github.com/puneetchopra2022/CICD-Project-1.git'
            }
        }
        stage(mvnbuild) {
            steps {
                sh 'mvn clean package'
            }
        
        }
        stage(dockerbuild) {
            steps {
              sh 'docker build -t puneet2022/learning:tomcatimage .'    
            }
        }
        stage(containerrun) {
                steps {
                sh 'docker stop tomcatserver'  
                sh 'docker rm tomcatserver'
                sh "docker run -dt -p 9090:8080 --name tomcatserver puneet2022/learning:tomcatimage"
                    
                }    
        }
        stage(dockerlogin)  {
            steps {
              sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'      ##   if stuck when jenkin job run we need to remove sudo from command 
            }
        }
        stage(pushtodocker) {
            steps {
              sh "sudo docker push puneet2022/learning:tomcatimage "        ##   if stuck when jenkin job run we need to remove sudo from command 
            }
        }
    }
    post{
    always {  
      sh 'docker logout'           
    }      
  }    
}



Note : - 
---------- Cloud agent in Jenkin
https://www.youtube.com/watch?v=GGAp74b68Qc 
https://phoenixnap.com/kb/how-to-configure-docker-in-jenkins  
------Forcefully restart job stuck 
    ssh onto the jenkins server
    cd to .jenkins/jobs/<job-name>/builds/
    rm -rf <build-number>
    restart jenkins
----------concept of webhook
 GitHub hook trigger for GITScm polling

Webhooks allow external services to be notified when certain events happen. When the specified events happen, we'll send a POST request to each of the URLs you provide.

Need to give Ip of Jenkin server in github  http://192.168.110.190:8080/github-webhook/



