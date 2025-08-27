namespace ELearningAPI.Models
{
    public class AssignmentSubmission
    {
        public int Id { get; set; }
        public int AssignmentId { get; set; }
        public string StudentId { get; set; } = string.Empty;
        public string SubmissionText { get; set; } = string.Empty;
        public string? FileUrl { get; set; }
        public DateTime SubmittedAt { get; set; } = DateTime.UtcNow;
        public double? Score { get; set; }
        public string? Feedback { get; set; }
        public DateTime? GradedAt { get; set; }
        public string Status { get; set; } = "Submitted"; // Submitted, Graded, Late
        
        // Navigation properties
        public virtual Assignment Assignment { get; set; } = null!;
        public virtual ApplicationUser Student { get; set; } = null!;
    }
}
