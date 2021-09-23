<template>
    <a v-if="invalid" :href="href"><slot></slot></a>
    <a v-else-if="isOuter" :href="href" target="_blank" ><slot></slot></a>
    <router-link v-else :to="href" target="_self" tag="a"><slot></slot></router-link>
</template>
<script>
export default {
    name: 'v-link',
    props: ['to','target'],
    computed: {
        href() {
            return this.invalid ? 'javascript:;' : this.to;
        },
        invalid() {
            return (!this.to || this.to == '#');
        },
        isOuter() {
            return (typeof this.to == 'string') && (this.to.constructor == String);
        }
    }
}
</script>