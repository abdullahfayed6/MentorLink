using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Presistence.Migrations
{
    /// <inheritdoc />
    public partial class ModifyTagAndSkillsTables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Skills_Mentors_MentorId",
                table: "Skills");

            migrationBuilder.DropForeignKey(
                name: "FK_Tags_Mentors_MentorId",
                table: "Tags");

            migrationBuilder.DropIndex(
                name: "IX_Tags_MentorId",
                table: "Tags");

            migrationBuilder.DropIndex(
                name: "IX_Skills_MentorId",
                table: "Skills");

            migrationBuilder.DropColumn(
                name: "MentorId",
                table: "Tags");

            migrationBuilder.DropColumn(
                name: "MentorId",
                table: "Skills");

            migrationBuilder.CreateTable(
                name: "MentorSkills",
                columns: table => new
                {
                    MentorsMentorId = table.Column<int>(type: "int", nullable: false),
                    SkillsId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MentorSkills", x => new { x.MentorsMentorId, x.SkillsId });
                    table.ForeignKey(
                        name: "FK_MentorSkills_Mentors_MentorsMentorId",
                        column: x => x.MentorsMentorId,
                        principalTable: "Mentors",
                        principalColumn: "MentorId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_MentorSkills_Skills_SkillsId",
                        column: x => x.SkillsId,
                        principalTable: "Skills",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "MentorTags",
                columns: table => new
                {
                    MentorsMentorId = table.Column<int>(type: "int", nullable: false),
                    TagsId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MentorTags", x => new { x.MentorsMentorId, x.TagsId });
                    table.ForeignKey(
                        name: "FK_MentorTags_Mentors_MentorsMentorId",
                        column: x => x.MentorsMentorId,
                        principalTable: "Mentors",
                        principalColumn: "MentorId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_MentorTags_Tags_TagsId",
                        column: x => x.TagsId,
                        principalTable: "Tags",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_MentorSkills_SkillsId",
                table: "MentorSkills",
                column: "SkillsId");

            migrationBuilder.CreateIndex(
                name: "IX_MentorTags_TagsId",
                table: "MentorTags",
                column: "TagsId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MentorSkills");

            migrationBuilder.DropTable(
                name: "MentorTags");

            migrationBuilder.AddColumn<int>(
                name: "MentorId",
                table: "Tags",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "MentorId",
                table: "Skills",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Tags_MentorId",
                table: "Tags",
                column: "MentorId");

            migrationBuilder.CreateIndex(
                name: "IX_Skills_MentorId",
                table: "Skills",
                column: "MentorId");

            migrationBuilder.AddForeignKey(
                name: "FK_Skills_Mentors_MentorId",
                table: "Skills",
                column: "MentorId",
                principalTable: "Mentors",
                principalColumn: "MentorId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Tags_Mentors_MentorId",
                table: "Tags",
                column: "MentorId",
                principalTable: "Mentors",
                principalColumn: "MentorId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
