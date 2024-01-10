<template>
    <div>
        <h1>Edit Skills</h1>
        <div class="container">
            <form @submit.prevent="updateSkills">
                <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
                    <div class="col form-group">
                        <label for="id_skill">ID SKILLS</label>
                        <input v-model="skills.id_skill" type="text" class="form-control" id="id_skill" disabled>
                    </div>

                    <div class="col form-group">
                        <label for="nama">NAMA</label>
                        <input v-model="skills.nama" type="text" class="form-control" id="nama" required>
                    </div>

                    <div class="col form-group">
                        <label for="level" class="form-label">LEVEL</label>
                        <input v-model="skills.level" type="text" class="form-control" id="level">
                    </div>

                    <div class="col form-group">
                        <label for="notes" class="form-label">NOTES</label>
                        <input v-model="skills.notes" type="text" class="form-control" id="notes">
                    </div>

                    <div class="col form-group">
                        <button type="submit" class="btn btn-primary">Update Data</button>
                    </div>

                </div>
            </form>
        </div>
    </div>
</template>
    
<script>
import axios from 'axios';
import router from '../router';

export default {
    data() {
        return {
            skills: {
                id_skill: '',
                nama: '',
                level: '',
                notes: '',
            },
        };
    },
    created() {
        this.fetchSkillsItem();
    },
    methods: {
        fetchSkillsItem() {
            const itemId = this.$route.params.id;
            axios.get(`http://localhost:8080/api/skills/${itemId}`)
                .then(response => {
                    this.skills = response.data.skill;
                    console.log(response.data.skill)
                })
                .catch(error => {
                    console.error('Error fetching skills item:', error);
                });
        },
        updateSkills() {
            axios.put(`http://localhost:8080/api/skills/${this.skills.id_skill}`, this.skills)
                .then(() => {
                    alert('skills item updated successfully');
                    router.push({ path: `/Skills` });

                })
                .catch(error => {
                    console.error('Error updating skills item:', error);
                });
        },
    },
};
</script>
    
<style></style>
    