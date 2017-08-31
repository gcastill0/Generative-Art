###Level 0 (optional) - Setup an Ubuntu VM###

- While it is not required, we recommend that you spin up a fresh linux VM via Vagrant or other tools so that you don't run into any OS or dependency issues. Here are instructions for setting up a Vagrant Ubuntu 12.04 VM.

---



**Phase 1**

To get started in this exercise, I used a free desktop that runs OSX 10.11.6. 

| Environment | Operating Environment | App |
| ------------- |:-------------:| -----:|
| On-premise | OSX 10 | MySQL, Random |

**Phase 2**

| Environment | Operating Environment | App |
| ------------- |:-------------:| -----:|
| On-premise | OSX 10 | MySQL, Random |
| GCP | Debian | Apache, Random |
| GCP | Debian | MySQL |


###Level 1 - Collecting Data###

- Sign up for Datadog (use "Datadog Recruiting Candidate" in the "Company" field), get the Agent reporting metrics from your local machine.
- Bonus question: In your own words, what is the Agent?
- Add tags in the Agent config file and show us a screenshot of your host and its tags on the Host Map page in Datadog.
- Install a database on your machine (MongoDB, MySQL, or PostgreSQL) and then install the respective Datadog integration for that database.
- Write a custom Agent check that samples a random value. Call this new metric: test.support.random

Here is a snippet that prints a random value in python:

```python
import random
print(random.random())
```    
###Level 2 - Visualizing Data###

- Since your database integration is reporting now, clone your database integration dashboard and add additional database metrics to it as well as your test.support.random metric from the custom Agent check.
- Bonus question: What is the difference between a timeboard and a screenboard?
- Take a snapshot of your test.support.random graph and draw a box around a section that shows it going above 0.90. Make sure this snapshot is sent to your email by using the @notification

###Level 3 - Alerting on Data###

- Since you've already caught your test metric going above 0.90 once, you don't want to have to continually watch this dashboard to be alerted when it goes above 0.90 again. So let's make life easier by creating a monitor.
- Set up a monitor on this metric that alerts you when it goes above 0.90 at least once during the last 5 minutes
- Bonus points: Make it a multi-alert by host so that you won't have to recreate it if your infrastructure scales up.
- Give it a descriptive monitor name and message (it might be worth it to include the link to your previously created dashboard in the message). Make sure that the monitor will notify you via email.
- This monitor should alert you within 15 minutes. So when it does, take a screenshot of the email that it sends you.
- Bonus: Since this monitor is going to alert pretty often, you don't want to be alerted when you are out of the office. Set up a scheduled downtime for this monitor that silences it from 7pm to 9am daily. Make sure that your email is notified when you schedule the downtime and take a screenshot of that notification.
