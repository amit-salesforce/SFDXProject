#!groovy

import groovy.json.JsonSlurperClassic
node {
    
    def ACT_VERSION='1.216.0'
    def ACT_PACKAGEID='04t5G000003rU0TQAU'

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }
    println 'Checked out Source'
    //check packages
   
	    
        if (env.BRANCH_NAME == 'master') {
            stage('Build Master') {
                echo 'Building sfdx master'
            }
        }
        try {   
	notifyBuild('STARTED')
		
        if (env.BRANCH_NAME == 'ActCI-Dev') {
            stage('Build Dev Sandbox via sfdx') {
                
               
                if (isUnix()) {
                    echo "isUnix ..................."
		    //rmsg = sh returnStdout: true, script: "sfdx force:package1:version:list -u PkgOrg"
		  // rmsg = sh returnStdout: true, script: "sfdx  force:source:deploy -x manifest/package.xml -u dglassman@readiness.salesforce.com.jenkinsdev "

	           // rmsg = sh returnStdout: true, script: "sfdx force:package:install  -p ${ACT_PACKAGEID} -u dglassman@readiness.salesforce.com.jenkinsdev  -w 15"
                  
                } else {
                    println 'Not Unix .......................'
                    rmsg = bat returnStdout: true, script: "sfdx force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
                }
            } //end stage
	
        }//end if dev
	if (env.BRANCH_NAME == 'ActCI-Qa') {
            stage('Build qa Sandbox Step  ') {
                println "Build qa Sandbox Step"
		
                 if (isUnix()) {
                    echo "isUnix ..................."
	          	         //   rmsg = sh returnStdout: true, script: "sfdx  force:source:deploy -x manifest/package.xml -u dglassman@readiness.salesforce.com.qa "
                } else {
                    println 'Not Unix .......................'
                    rmsg = bat returnStdout: true, script: "sfdx force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
                }
            } //end stage
	  
	
        }//end if qa
	 if (env.BRANCH_NAME == 'ActCI-Uat') {
            stage('Build uat Sandbox via sfdx') {
                
 
                if (isUnix()) {
                    echo "isUnix ..................."
                   // rmsg = sh returnStdout: true, script: "sfdx force:source:deploy -x manifest/package.xml -u dglassman@readiness.salesforce.com.uat "
                } else {
                    println 'Not Unix .......................'
                    rmsg = bat returnStdout: true, script: "sfdx force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
                }
            } //end stage
	
        }//end if uat   
	  if (env.BRANCH_NAME == 'ActCI-Prod') {
            stage('Build uat Sandbox via sfdx') {
                
               
                if (isUnix()) {
                    echo "isUnix ..................."
                    //rmsg = sh returnStdout: true, script: "sfdx force:source:deploy -x manifest/package.xml -u dglassman@readiness.salesforce.com.jenkinprod"
                } else {
                    println 'Not Unix .......................'
                    rmsg = bat returnStdout: true, script: "sfdx force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
                }
            } //end stage
	
        }//end if prod   
	    } catch (e) {
            // If there was an exception thrown, the build failed
             currentBuild.result = "FAILED"
               throw e
             } finally {
              // Success or failure, always send notifications
             notifyBuild(currentBuild.result)
          }
	    
    
}//end node

def notifyBuild(String buildStatus = 'STARTED',String version,String id) {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
	def summary = "${subject} (${env.BUILD_URL}) Appiphony Package ${version} ID: ${id}  Target Release ACT 19.0 "
  def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

 echo "${summary}"
//slackSend (color: colorCode, message: summary)
    
}
