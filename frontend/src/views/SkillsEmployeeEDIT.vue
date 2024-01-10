<template>
    <div>
        <h1>Edit Skills</h1>
        <div class="container">
            <form @submit.prevent="updateSkills">
                <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
                    <div class="col">
                        <div class="">
                            <label for="id_skill_karyawan" class="form-label">ID SKILL KARYAWAN</label>
                            <input v-model="newSkill.id_skill_karyawan" type="text" class="form-control"
                                id="id_skill_karyawan" disabled>
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="id_skill" class="form-label">ID SKILL</label>
                            <select v-model="newSkill.id_skill" class="form-select" id="id_skill">
                                <option v-for="skill in skills" :value="skill.id_skill" :key="skill.id_skill">
                                    {{ skill.nama }}
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="nomor_induk" class="form-label">NOMOR INDUK</label>
                            <select v-model="newSkill.nomor_induk" class="form-select" id="nomor_induk">
                                <option v-for="employee in employees" :value="employee.nomor_induk"
                                    :key="employee.nomor_induk">
                                    {{ employee.nama }}
                                </option>
                            </select>
                        </div>
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
            newSkill: {
                id_skill_karyawan: '',
                id_skill: '',
                nomor_induk: '',
            },
            skills: [],
            employees: [],
        };
    },
    created() {
        this.fetchSkillsItem();
    },
    mounted() {
        this.fetchSkills();
        this.fetchEmployees();

    },
    methods: {
        updateSkills() {
            axios.put(`http://localhost:8080/api/employeeSkills/${this.newSkill.id_skill_karyawan}`, this.newSkill)
                .then(() => {
                    alert('skills item updated successfully');
                    router.push({ path: `/SkillsEmployee` });

                })
                .catch(error => {
                    console.error('Error updating skills item:', error);
                });
        },
        fetchSkillsItem() {
            const itemId = this.$route.params.id;
            axios.get(`http://localhost:8080/api/employeeSkills/${itemId}`)
                .then(response => {
                    this.newSkill = response.data.skillEmployee;
                    console.log(response.data.skillEmployee)
                })
                .catch(error => {
                    console.error('Error fetching skills item:', error);
                });
        },

        fetchSkills() {
            axios.get('http://localhost:8080/api/skills')
                .then(response => {
                    this.skills = response.data.skills;
                    console.log(this.skills)
                })
                .catch(error => {
                    console.error('Error fetching location:', error);
                });
        },
        fetchEmployees() {
            axios.get('http://localhost:8080/api/employees')
                .then(response => {
                    this.employees = response.data.employees;
                    console.log(this.employees)
                })
                .catch(error => {
                    console.error('Error fetching location:', error);
                });
        },
    },
};
</script>
    
<style></style>
    