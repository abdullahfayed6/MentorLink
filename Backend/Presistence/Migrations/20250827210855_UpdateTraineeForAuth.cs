using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Presistence.Migrations
{
    /// <inheritdoc />
    public partial class UpdateTraineeForAuth : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Password",
                table: "Trainees",
                newName: "Username");

            migrationBuilder.AddColumn<DateTime>(
                name: "CreatedAt",
                table: "Trainees",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "LastLoginAt",
                table: "Trainees",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PasswordHash",
                table: "Trainees",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "RefreshToken",
                table: "Trainees",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "RefreshTokenExpiryTime",
                table: "Trainees",
                type: "datetime2",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CreatedAt",
                table: "Trainees");

            migrationBuilder.DropColumn(
                name: "LastLoginAt",
                table: "Trainees");

            migrationBuilder.DropColumn(
                name: "PasswordHash",
                table: "Trainees");

            migrationBuilder.DropColumn(
                name: "RefreshToken",
                table: "Trainees");

            migrationBuilder.DropColumn(
                name: "RefreshTokenExpiryTime",
                table: "Trainees");

            migrationBuilder.RenameColumn(
                name: "Username",
                table: "Trainees",
                newName: "Password");
        }
    }
}
