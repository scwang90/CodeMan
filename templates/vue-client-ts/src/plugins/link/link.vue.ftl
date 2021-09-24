<template>
    <a v-if="invalid" :href="href"><slot></slot></a>
    <a v-else-if="isOuter" :href="href" target="_blank" ><slot></slot></a>
    <router-link v-else :to="href" target="_self" tag="a"><slot></slot></router-link>
</template>
<script lang="ts">
import Vue from 'vue'
import Component from 'vue-class-component';
import { Prop } from 'vue-property-decorator';

@Component({ name: 'v-link' })
export default class VLink extends Vue {
    @Prop() private to?: string
    @Prop() private target?: string

    get href(): string | undefined {
        return this.invalid ? 'javascript:;' : this.to;
    }

    get invalid(): boolean {
        return (!this.to || this.to == '#');
    }

    get isOuter(): boolean {
        return (typeof this.to == 'string') && (this.to.constructor == String);
    }
}
</script>
