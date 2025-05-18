## Technical Requirements Document: CarbonGuessr Mobile App Prototype

**1. Introduction**

This document outlines the technical requirements for the development of a prototype for the CarbonGuessr mobile application. The primary goal of this prototype is to implement the core single-player gameplay loop, focusing on user interaction, data display, and adherence to best practices in software development. 

**2. Core Principles**

The development process must prioritize the following:

* **Readability:** Code should be well-structured, clearly commented, and easy for human developers and LLMs to understand.
* **Maintainability:** The codebase should be designed for ease of modification, debugging, and future enhancements.
* **Scalability:** While this is a prototype, the foundational architecture should allow for future expansion of features and user base without requiring major refactoring.

**3. Technology Stack**

The application will be developed using the following technologies:

* **Framework:** Flutter
* **State Management:** Riverpod
* **Navigation:** Go_Router
* **Data Classes/Serialization:** Freezed

**4. Functional Requirements Implementation**

This section details the technical implementation of the functional requirements. It assumes that the 'carbon' collection is already available in the database, but stresses that the app should be able to function with other collections as well. 

**4.1. Game Modes**

The prototype will implement two single-player game modes: Simple Mode and Research Mode.

**4.1.1. Simple Mode**
    * **Gameplay Logic:**
        * Present 5 item pairings sequentially per game session.
        * Item data (name, description, value) will be retrieved from the existing item database API.
    * **User Interface (UI):**
        * Display the pair of items/activities with their short descriptions (text and potentially iconographic representations if available from the database).
        * Implement a 30-second countdown timer per pairing, clearly visible to the user.
        * Provide a numerical input field for the user to enter their estimated ratio.
        * Display the score for the current round after the user submits their estimation. 
        * Display the total score for the game session at the end of the 5 pairings. 
    * **Scoring:**
        * Calculated based on the accuracy of the user's estimated ratio compared to the correct ratio (details in section 4.3). 

**4.1.2. Research Mode**
    * **Gameplay Logic:**
        * Present 5 item pairings sequentially per game session. 
        * Item data retrieval will be identical to Simple Mode.
    * **User Interface (UI):**
        * Display item pairs and descriptions as in Simple Mode. 
        * Implement a 3-minute countdown timer per pairing. 
        * Include a button or link that allows the user to open an external web browser for research purposes. The app should gracefully handle returning from the browser.
        * Provide a numerical input field for the estimated ratio.
        * Display round score after submission. 
        * Display total session score at the end. 
    * **Scoring:**
        * Calculated based on the accuracy of the user's estimated ratio (details in section 4.3). 

**4.2. Item Database Interaction**

* The application will assume that the API for the item database is fully functional and accessible.
* The application will make API calls to retrieve item details, including name, description, and value.
* The presentation order of items within a pair should be randomized.

**4.3. Estimation and Scoring Mechanism**

* **User Estimation Input:**
    * A simple numerical input field will be used for players to submit their estimated value ratio (i.e. the value of item A divided by the value of item B).
* **Ratio Calculation (Backend/Client-Side Logic):**
    * The "correct" value ratio will be calculated by dividing the value of item A by the value of item B. This calculation can occur client-side after retrieving the values.
* **Accuracy Calculation:**
    * A formula will be implemented to determine the accuracy of the player's estimate against the correct ratio. An illustrative example: `AccuracyPercentage = 100 - (abs(CorrectRatio - PlayerEstimate) / CorrectRatio) * 100`.This formula should be refined to handle edge cases (e.g., division by zero if CorrectRatio could be zero, though unlikely for footprint data) and provide a fair scoring range.
* **Round Scoring:**
    * The score for each round will be directly derived from the calculated accuracy percentage. For instance, Accuracy Percentage could translate to points (e.g., 90% accuracy = 90 points).  
* **Game Session Scoring:**
    * The total score for a game session is the sum of scores from all 5 rounds.

**4.4. Timer Implementation**

* **Simple Mode Timer:**
    * A visual countdown timer of 30 seconds per round must be implemented.
    * Consider simple auditory cues to indicate when time is running out (optional for prototype if it complicates LLM generation significantly).
* **Research Mode Timer:**
    * A visual countdown timer of 3 minutes per round must be implemented.

**4.5. User Interface (UI) and User Experience (UX)**

* **General Design:**
    * Prioritize a clean, intuitive, and uncluttered design.
    * Ensure text is easily readable.
* **Item Pair Display:**
    * Clearly present the names and descriptions of the two items/activities in each pairing. 
* **Input Method:**
    * Ensure the numerical input field is easy to use.
* **Feedback and Results Display:**
    * Clearly display:
        * Score for each round.
        * The correct ratio (revealed after the user submits their estimate).
        * The total game score at the end of a session.
    * Use simple visual feedback (e.g., text color changes) to indicate estimation accuracy (e.g., green for high accuracy, yellow for medium, red for low).
* **Game Mode Selection Screen:**
    * Implement a clear screen for users to select either "Simple Mode" or "Research Mode".

**5. Non-Functional Requirements**

* **Performance:**
    * The application should be responsive on target mobile devices.
    * Loading times between screens and for item data should be minimized.
* **Code Structure (Leveraging Flutter, Riverpod, Go_Router, Freezed):**
    * **Modularity:** Structure the code into logical modules (e.g., features, services, UI components).
    * **State Management (Riverpod):** Utilize Riverpod providers for managing application state effectively. Ensure state is localized where possible and global state is managed cleanly.
    * **Navigation (Go_Router):** Define clear navigation paths using Go_Router. Routes should be well-defined and managed.
    * **Data Models (Freezed):** Use Freezed to generate immutable data classes for API responses and internal data structures, ensuring type safety and reducing boilerplate.
    * **Error Handling:** Implement basic error handling for API calls (e.g., displaying a generic error message if data cannot be fetched).

This document provides the necessary technical requirements for an LLM to generate the codebase for the CarbonGuessr prototype. Emphasis should be on fulfilling the specified functional components while adhering to the core principles of readability, maintainability, and scalability within the chosen technology stack.