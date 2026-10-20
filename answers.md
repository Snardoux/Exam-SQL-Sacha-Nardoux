# Investigation and corrections

Name / student ID: NARDOUX Sacha

## Q3 — Subscription snapshot

Problem identified: monthly_subscription_val is duplicated.

Explanation: Joining sessions adds one row for each session a user has. This repeats that user’s subscription price during the calculation of thje SUM.

Correction and reasoning: Remove the sessions join because it isn’t needed to calculate the total. 

## Q4 — Signup population

Problem identified and explanation : The Wehre filter removes users with no September session. For those users, the Left Join produces Null session values, and the date conditions in Where reject those rows. This makes the join behave like an inner join. 

Correction and reasoning: Move the September date filter into the On clause so users without a matching session remain in the results. Count all distinct users ID registered, and count distinct session-side user IDs for September-active users.

## Q5A — Counting

Problem identified and explanation: For a user with no sessions, the Left Join still produces one row, with Null values for the session columns. Count(*) counts that row, so it returns one row instead of no row.

Correction and reasoning: Use Count(s.user_id). It counts only non-Null session user IDs, returning the number of sessions for each user and nothing for users with none.

## Q5B — Previous session

Problem identified and explanation: Lag() has no Order By, so the database has no defined order for sessions within the user’s partition.

Correction and reasoning: Order each user’s sessions by session_start. Add sessions_id to decide if two or more sessions with the same start time can so have still a chronological order.

## Q5C — Design recommendation

Change and concrete SQL (or reference to my SQL file): Create an index on user_id

Reasoning: The query filters on user_id, and usually only a small fraction of rows match. The index helps the querty find that user’s sessions without scanning whole of the  entire tables.

Cost or limitation: The index uses additional storage to the actual storage of the database.

## Q6 — Visual critique

| Issue (exactly three)                                                   | Consequence for interpretation       | Proposed correction             |
| ----------------------------------------------------------------------- | ------------------------------------ | ------------------------------- |
| 1 Using a pie Chart for a timeline problem                              | We cant see the evolution over month | Use a linear chart              |
| 2 The Text on the Chart was the SUM of the User, not the Count Distinct | False metrics with higher number     | Put the uder in CTD and not SUM |
| 3                                                                      |                                      |                                 |

Changes made in the saved workbook:

Put in the linear chart ans change the text to display the Distinct Count of User and not the SUM

## Q7 — Metric and grain

Source row grain: The actual source row grain is the Second spend by Event, not by User.

Problem identified and explanation: Actually, the average is the average second spend on each event, but some user can have many event, so the title Average Engagement per Active User — 2026 is not true, we have to either change ot for Average Engagement per Event — 2026 or calculate from another way.

Corrected calculation: 

One-sentence interpretation of my corrected value, with unit, population and period:

## Bonus — Optional

Why user_id must permit multiple subscription rows:

## Submission check

- [ ] SQL saved in sql/student_answers.sql.
- [ ] Explanations above completed.
- [ ] submission/corrected_workbook.twbx saved and reopened.
