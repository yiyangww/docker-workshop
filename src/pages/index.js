import { useState } from "react";

export default function Home() {
  const [answers, setAnswers] = useState({});
  const [submitStatus, setSubmitStatus] = useState("");

  const questions = [
    {
      id: 1,
      text: "What is Docker?",
      options: ["A. docker is dockr", "B. docker ok", "C. idk", "D. good"],
    },
    {
      id: 2,
      text: "Why use Docker?",
      options: ["A. Easy", "B. Portable", "C. Fast", "D. All of the above"],
    },
    {
      id: 3,
      text: "What database is used?",
      options: ["A. MongoDB", "B. PostgreSQL", "C. MySQL", "D. SQLite"],
    },
    {
      id: 4,
      text: "What is Prisma?",
      options: ["A. ORM", "B. Database", "C. Server", "D. Frontend"],
    },
  ];

  const handleSelect = (questionId, option) => {
    setAnswers((prev) => ({ ...prev, [questionId]: option }));
  };

  const handleSubmit = async () => {
    try {
      setSubmitStatus("Submitting...");
      console.log("Submitting answers:", answers);

      const response = await fetch("/api/submit", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ answers }),
      });

      const data = await response.json();
      console.log("Submission Response:", data);

      if (!response.ok) {
        throw new Error(data.error || "Failed to submit answers");
      }

      setSubmitStatus("Answers submitted successfully!");
    } catch (error) {
      console.error("Error submitting answers:", error);
      setSubmitStatus(`Error: ${error.message}`);
    }
  };

  return (
    <div style={{ maxWidth: "800px", margin: "0 auto", padding: "20px" }}>
      <h1 style={{ textAlign: "center", marginBottom: "40px" }}>
        CSC309 Lab10 Quiz
      </h1>
      {questions.map((q) => (
        <div key={q.id} style={{ marginBottom: "40px" }}>
          <h3 style={{ marginBottom: "20px" }}>{q.text}</h3>
          <div
            style={{ display: "flex", flexDirection: "column", gap: "10px" }}
          >
            {q.options.map((opt) => (
              <button
                key={opt}
                onClick={() => handleSelect(q.id, opt)}
                style={{
                  padding: "10px 20px",
                  textAlign: "left",
                  backgroundColor: answers[q.id] === opt ? "#e0e0e0" : "white",
                  border: "1px solid #ccc",
                  borderRadius: "4px",
                  cursor: "pointer",
                  transition: "background-color 0.2s",
                }}
                onMouseOver={(e) =>
                  (e.target.style.backgroundColor = "#f0f0f0")
                }
                onMouseOut={(e) =>
                  (e.target.style.backgroundColor =
                    answers[q.id] === opt ? "#e0e0e0" : "white")
                }
              >
                {opt}
              </button>
            ))}
          </div>
        </div>
      ))}
      <button
        onClick={handleSubmit}
        style={{
          display: "block",
          margin: "40px auto",
          padding: "10px 30px",
          fontSize: "16px",
          backgroundColor: "#0070f3",
          color: "white",
          border: "none",
          borderRadius: "4px",
          cursor: "pointer",
        }}
      >
        Submit
      </button>
      {submitStatus && (
        <div
          style={{
            textAlign: "center",
            marginTop: "20px",
            color: submitStatus.includes("Error") ? "red" : "green",
          }}
        >
          {submitStatus}
        </div>
      )}
    </div>
  );
}
