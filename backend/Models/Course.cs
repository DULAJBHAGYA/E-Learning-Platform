namespace ELearningAPI.Models
{
    public class Course
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string? Thumbnail { get; set; }
        public decimal Price { get; set; }
        public string Category { get; set; } = string.Empty;
        public string Level { get; set; } = "Beginner"; // Beginner, Intermediate, Advanced
        public int Duration { get; set; } // in minutes
        public string InstructorId { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime? UpdatedAt { get; set; }
        public bool IsPublished { get; set; } = false;
        public bool IsFeatured { get; set; } = false;
        public double Rating { get; set; } = 0.0;
        public int TotalStudents { get; set; } = 0;
        public int TotalLessons { get; set; } = 0;
        
        // Navigation properties
        public virtual ApplicationUser Instructor { get; set; } = null!;
        public virtual ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>();
        public virtual ICollection<Lesson> Lessons { get; set; } = new List<Lesson>();
        public virtual ICollection<Assignment> Assignments { get; set; } = new List<Assignment>();
        public virtual ICollection<CourseMaterial> Materials { get; set; } = new List<CourseMaterial>();
    }
}
