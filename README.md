# FindYourParadise

An HPCC Systems Hackathon Challenge!

# Challenge

## Find Your Paradise by weighing selected "quality of life" factors

Have you ever thought about building an application that can help people find places to live that maximize their quality of life and happiness?

The goal of this challenge is to analyze numerous datasets across different categories and make correlations with the data, using the HPCC Systems platform. After analyzing, design an interface to query this data to deliver to the user a scoring system output to help measure where they should most likely want to live. Users should be given choices in an easy-to-use form that when submitted will generate a unique set of scores based on locations (Example: By State).

Every person’s definition of what make them happy can vary depending on several factors. To this challenge, we have narrowed these factors to four (4) categories:
•	Crime 
•	Environment (Weather)
•	Health 
•	Education

**Crime** – A dataset by US State with crimes between 2018-2021 is provided. Data points can include the number of crimes by State and Violent Crimes by State.

**Climate** – A dataset of Storm Data in the US over the last 10 years will be provided. Data Points can include number of storms by State, also injuries and fatalities due to a weather incident.

**Health** – A mortality rate by State from 1980 to 2020 dataset will be provided. Data points can include total mortality and/or average mortality by year and State.

**Education** – A dataset of the number of public and private schools by State will be provided. Data points include total school by State and percentage of Private Schools available to the Total Schools by State. Also, enrollment and student-to-teacher ratio can be a factor.  

## Tools

Start by installing one or both of the following IDEs: 

Install the flagship ECL IDE if you are a Windows user [ECL IDE Install](https://hpccsystems.com/download/#h-bare-metal-non-containerized-platform).

If you have a Mac or Linux box, install the Visual Studio Code IDE for your appropriate O/S, and then refer to the Installation PDF in the Docs folder of this repository to configure your IDE for ECL usage.  
PDFs in the Docs folder of this repository can be found to guide you through the installation and configuration.

[VS-Code IDE Install Page](https://code.visualstudio.com/download).

Download QuickStart.mod located in this repository's root folder. This file has the initial code you need for this challenge. 
The import process will be discussed at the Workshops, but in both IDEs simply open the MOD file and follow the prompts. CTRL+O in the ECL IDE, and the F1 key in VS-Code will pop up the command dialog, and look for the "ECL: Import 'mod' file" command. 

If you need more information on the ECL jobs you are running please use [ECL Watch Page](http://54.177.201.47:8010)

**Note: This cluster will only be active during the event!** After the event, you can create your own localized container cluster, or visit our public "Play" Cluster: (https://play.hpccsystems.com:18010) 

For a quick start on ECL syntax, please visit the [Learn ECL](https://hpccsystems-solutions-lab.github.io/) page. 

## Additional Resources

- Learn ECL Academy
https://hpccsystems-solutions-lab.github.io

- ECL training containing six short videos
https://www.youtube.com/watch?time_continue=192&v=Lk78BCCtM-0

- ECL documentation
http://cdn.hpccsystems.com/releases/CE-Candidate-8.10.12/docs/EN_US/ECLLanguageReference_EN_US-8.10.12-1.pdf

- Visualization document
https://cdn.hpccsystems.com/releases/CE-Candidate-8.10.12/docs/EN_US/VisualizingECL_EN_US-8.10.12-1.pdf

- Standard Library
https://cdn.hpccsystems.com/releases/CE-Candidate-8.10.12/docs/EN_US/ECLStandardLibraryReference_EN_US-8.10.12-1.pdf

- Machine Learning
https://hpccsystems.com/download/free-modules/machine-learning-library


## Challenge Expectation

Judges will consider followings during final presentation:

- Problem that was chosen (What categories and datasets were selected)
- How you approached the solution
- Display results (ROXIE or Visualization)
- Drawing conclusion (Where is your Paradise?)
- Demo of work via a PowerPoint presentation or live demo

Data points will be created for each category, sorted by US State or by County. The product should be able to allow selection of one or all categories, and then weigh each category in order of importance. Based on the weigh a score will be generated for each category selected and a "Top 10" list of States with their weighed scores will be displayed.

## Mentors

<div class="mentors">

<div>
<img src="./Images/Bob.jpg" alt="Bob Foreman" width="85" height="100" />
<p>Bob has been an ECL Trainer for the past 12 years, and has been a Technology Teacher for longer than he wants to admit. He will be your primary onsite contact regarding all ECL related questions during this event.</p>
</div>

<div>
<img src="./Images/George.jpg" alt="George Foreman" width="100" />
<p>George is our HPCC Systems Product Specialist and Technical Writer. He will be available onsite to help you with locating the resources you need during this event.</p>
</div>
<div></div>
</div>

