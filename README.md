![image](https://github.com/puneetchopra2022/CICD-Project-1/assets/96010416/62eb29a4-e73c-4b0f-a733-ab1ca2f10dab)


![image](https://github.com/puneetchopra2022/CICD-Project-1/assets/96010416/e532002a-a440-4417-9b8b-1bf97c9f1015)



Stage 1: Gitclone ( Make sure pom.xml file should be available ) https://maven.apache.org/guides/introduction/introduction-to-the-pom.html 
         A Project Object Model or POM is the fundamental unit of work in Maven. It is an XML file that contains information about the project and configuration details used by Maven to build the project
		 Availability of GitHub account & repository  ## Github is use for Distributer Source Code management Tool
         https://github.com/puneetchopra2022/CICD-Project-1.git 
        		 Make sure to install Git on Jenkin Server 

Stage 2: Maven build 
         Install maven on Jenkin, Manage Jenkin>tools>install maven 
		 
Stage 3: docker build 
         In order Jenkin to communicate with Docker user please add docker user to docker group adim & reboot machine , reference https://stackoverflow.com/questions/47854463/docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socke
          # sudo usermod -a -G docker $USER
          # reboot 

Stage 4: containerun 

Stage 5 dockerlogin follow https://thetechdarts.com/deploy-to-dockerhub-using-jenkins-declarative-pipeline/

Stage 6: dockerpush 

Stage 7: Post call for docker logout

Automate this Job with enabling of Gitwebhook 
