# Imola GP SQL Analysis for Franco Colapinto’s 2025 Debut

**Project Goal**  
This project analyzes historical Formula 1 data at Imola to extract strategic insights for Franco Colapinto’s 2025 debut. The aim is to identify driver trends, qualifying-to-race performance, pit strategies, and grid-based scoring probabilities to understand how Colapinto could realistically score points in his first F1 Grand Prix at Imola.

---

## Overview

- **Dataset**: Formula 1 relational database (1950–2024)
- **Focus**: Imola GP, particularly seasons 2020–2024
- **Tools Used**: Microsoft SQL Server (T-SQL)
- **Query Types**:
  - General Performance Metrics
  - Strategic Insights for Race Execution
- **Project Type**: Portfolio SQL project for real-world scenario modeling and data storytelling

---

## Folder Structure

- `queries/general/`  
  Historical F1 metrics (e.g., most wins, poles, constructor dominance)

- `queries/race_strategy/`  
  Strategy-oriented insights for Franco Colapinto’s debut (e.g., qualifying upsets, pit stop analysis)

- `docs/`  
  Supporting files (e.g., this README)

---

## Key Queries & Insights

### General Queries (`general_queries.sql`)
- **Task 1**: Top 5 Drivers with Most Wins at Imola  
- **Task 2**: Top 5 Drivers with Most Pole Positions  
- **Task 3**: Most Constructor Wins  
- **Task 8**: Pole-to-Win Conversion Rate for Constructors (5+ poles)

### Strategy Queries (`race_strategy_queries.sql`)
- **Task 10**: Rookie Performance in First Imola Races  
- **Task 13**: Drivers Outside Top 5 in Qualifying Who Scored Points *(Updated to focus on points finishes for Colapinto’s 2025 goal)*  
- **Task 15**: Points Scoring Probability by Starting Position  
- **Task 17**: Pit Stop Time Trends (Fastest & Average by Year/Constructor)

---

## Project Highlights

- 80%+ chance of scoring points when starting P4–P6 at Imola (2020–2024)
- Historical data shows mid-grid starters (P6+) have consistently finished in the points
- Pit stop efficiency: Delta leads in consistency and reliability (avg. duration <3s)
- Rookie trend analysis provides benchmark for Colapinto’s first race performance
- Clear data storytelling for team strategy decisions

---

## Technical Stack

- SQL features used:  
  `CTEs`, `JOINs`, `Window Functions`, `CASE`, `GROUP BY`, `HAVING`, `ROUND`, `CAST`

- Cleaned and organized into modular `.sql` files with documented headers per task

---

## How to Use

1. Clone the repo  
2. Load Formula 1 SQL database into Microsoft SQL Server  
3. Run queries in each `.sql` file under `/queries/`  
4. Adapt queries for additional strategy insights or visualization tools

---

## Use Case

Ideal for:
- Data analysts showcasing real-world sports/business cases
- Recruiters evaluating SQL, data modeling, and analytical storytelling
- F1 fans turning data into actionable race intelligence

---

## Portfolio & Social

- **Project Page**: [See full analysis here](https://matirossi87mr.wixsite.com/matiasrossi-porfolio/post/optimizing-mco-s-holiday-operations-a-data-driven-analysis-of-december-2024-flight-traffic)  
- **LinkedIn Post**: [Coming soon...]  
- **GitHub Profile**: [github.com/matiasrossi87](https://github.com/matiasrossi87)

---

## Credits

This project was inspired by Franco Colapinto’s 2025 debut in Formula 1.  
Queries were carefully reviewed to ensure clarity and accuracy — special thanks to the data engineering guidance from Grok AI, and the open-source F1 dataset community.

---

## Notes

- Tasks were designed with recruiter-readability and real-world presentation in mind  
- Critical fixes applied to ensure data integrity (Task 8: joins; Task 10: syntax case sensitivity)  
- Task 11 was intentionally excluded due to lack of reliable lap time context

---

Let’s connect — I’m always happy to discuss data, racing, or your next analytics hire!
