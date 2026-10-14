# Hibernate Knowledge Test

This is a small HTML/JSP project that introduces Hibernate and checks a
student's summary of the lesson.

## Run it

Deploy the project directory as a web application in a JSP-capable servlet
container such as Apache Tomcat, then open `about.html` through the container.
The JSP endpoint must run on the server; opening the HTML files directly from
the filesystem will not process submissions.

## Validation and scoring

- The name must be exactly 10 ASCII letters and start with an uppercase letter.
- The email must have a non-empty local part and end in `@gmail.com`.
- The summary must include at least 7 of the 10 distinct lesson keywords.
- Scores are awarded at the highest matching threshold: more than 50 words and
  70% keyword coverage gives 7; more than 70 and 80% gives 8; more than 90 and
  90% gives 9; more than 100 and 100% gives 10. Otherwise the score is 0.
