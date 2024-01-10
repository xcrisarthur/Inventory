<template>
    <div>
        <h1>Skills Employee Add Data</h1>

        <div class="container">
            <form @submit.prevent="createSkills">
                <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
                    <div class="col">
                        <div class="">
                            <label for="id_skill_karyawan" class="form-label">ID SKILL KARYAWAN</label>
                            <input v-model="newSkill.id_skill_karyawan" type="text" class="form-control" id="id_skill_karyawan" >
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
                                <option v-for="employee in employees" :value="employee.nomor_induk" :key="employee.nomor_induk">
                                    {{ employee.nama }}
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="col">
                        <button type="submit" class="btn btn-primary">Add Data</button>
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
    mounted() {
        this.fetchSkills();
        this.fetchEmployees();

    },
    methods: {
        createSkills() {
            axios.post('http://localhost:8080/api/employeeSkills', this.newSkill)
                // eslint-disable-next-line no-unused-vars
                .then(response => {
                    this.newSkill = {};
                    router.push({ path: `/SkillsEmployee` });
                })
                .catch(error => {
                    console.error('Error creating inventory:', error);
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