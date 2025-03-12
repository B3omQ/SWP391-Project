/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;



/**
 *
 * @author emkob
 */
public class Article {
    private int id;
    private String title;
    private String description;
    private String category;
    private Timestamp publishDate;
    private int authorId;
    private String imageUrl;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructor đầy đủ
    public Article(int id, String title, String description, String category, Timestamp publishDate, 
                   int authorId, String imageUrl, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.category = category;
        this.publishDate = publishDate;
        this.authorId = authorId;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Article(String title, String description, String category, int authorId, String imageUrl) {
        this.title = title;
        this.description = description;
        this.category = category;
        this.authorId = authorId;
        this.imageUrl = imageUrl;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Timestamp getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Timestamp publishDate) {
        this.publishDate = publishDate;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}