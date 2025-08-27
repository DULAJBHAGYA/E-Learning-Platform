namespace ELearningAPI.Models
{
    public class CourseMaterial
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string FileUrl { get; set; } = string.Empty;
        public string FileType { get; set; } = string.Empty; // PDF, DOC, VIDEO, etc.
        public int FileSize { get; set; } // in bytes
        public int CourseId { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public bool IsActive { get; set; } = true;
        public int Order { get; set; } = 0;
        
        // Navigation properties
        public virtual Course Course { get; set; } = null!;
    }
}
