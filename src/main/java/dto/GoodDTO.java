package dto;

public class GoodDTO {
    String id;
    String name;
    String description;
    GoodStatus status;
    String owner;

    public GoodDTO(String name, String description, String owner) {
        this.name = name;
        this.description = description;
        this.owner = owner;
    }

    public GoodDTO(String id, String name, String description, GoodStatus status, String owner) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.status = status;
        this.owner = owner;
    }

    public GoodDTO(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public GoodStatus getStatus() {
        return status;
    }

    public void setStatus(GoodStatus status) {
        this.status = status;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    @Override
    public String toString() {
        return "GoodDTO{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", status=" + status +
                ", owner='" + owner + '\'' +
                '}';
    }
}

