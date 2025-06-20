<script>
import { useDarkMode } from 'widget/composables/useDarkMode';

export default {
  name: 'TestimonialCard',
  props: {
    testimonial: {
      type: Object,
      required: true,
      validator(value) {
        return (
          value &&
          typeof value.name === 'string' &&
          typeof value.text === 'string'
        );
      },
    },
  },
  setup() {
    const { getThemeClass } = useDarkMode();
    return { getThemeClass };
  },
  computed: {
    avatarUrl() {
      return this.testimonial.avatar || '/images/testimonials/default-avatar.png';
    },
    companyLogoUrl() {
      return this.testimonial.companyLogo || null;
    },
    highlightedText() {
      if (!this.testimonial.highlightPhrase) {
        return this.testimonial.text;
      }
      
      const phrase = this.testimonial.highlightPhrase;
      const regex = new RegExp(`(${phrase})`, 'gi');
      return this.testimonial.text.replace(regex, '<mark class="highlight">$1</mark>');
    },
  },
};
</script>

<template>
  <div
    class="testimonial-card"
    :class="getThemeClass('bg-white', 'dark:bg-slate-800')"
    role="article"
    :aria-label="`Depoimento de ${testimonial.name}`"
  >
    <!-- Quote Icon -->
    <div class="quote-icon" :class="getThemeClass('text-woot-500', 'dark:text-woot-400')">
      <svg
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="currentColor"
        aria-hidden="true"
      >
        <path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h4v10h-10z"/>
      </svg>
    </div>

    <!-- Testimonial Text -->
    <div class="testimonial-text">
      <p
        class="text-content"
        :class="getThemeClass('text-slate-700', 'dark:text-slate-200')"
        v-html="highlightedText"
      ></p>
    </div>

    <!-- Author Info -->
    <div class="author-info">
      <div class="author-avatar">
        <img
          :src="avatarUrl"
          :alt="`Foto de ${testimonial.name}`"
          class="avatar-image"
          loading="lazy"
          @error="$event.target.src = '/images/testimonials/default-avatar.png'"
        />
      </div>
      
      <div class="author-details">
        <h4
          class="author-name"
          :class="getThemeClass('text-slate-900', 'dark:text-slate-100')"
        >
          {{ testimonial.name }}
        </h4>
        
        <p
          v-if="testimonial.position"
          class="author-position"
          :class="getThemeClass('text-slate-600', 'dark:text-slate-400')"
        >
          {{ testimonial.position }}
        </p>
        
        <div v-if="testimonial.company" class="company-info">
          <img
            v-if="companyLogoUrl"
            :src="companyLogoUrl"
            :alt="`Logo da ${testimonial.company}`"
            class="company-logo"
            loading="lazy"
            @error="$event.target.style.display = 'none'"
          />
          <span
            class="company-name"
            :class="getThemeClass('text-slate-600', 'dark:text-slate-400')"
          >
            {{ testimonial.company }}
          </span>
        </div>
      </div>
    </div>

    <!-- Rating Stars (if provided) -->
    <div v-if="testimonial.rating" class="rating" :aria-label="`Avaliação: ${testimonial.rating} de 5 estrelas`">
      <div class="stars">
        <span
          v-for="star in 5"
          :key="star"
          class="star"
          :class="{
            'filled': star <= testimonial.rating,
            'empty': star > testimonial.rating
          }"
          :aria-hidden="true"
        >
          ★
        </span>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
@import 'widget/assets/scss/variables.scss';
@import 'dashboard/assets/scss/mixins.scss';

.testimonial-card {
  @include border-light;
  border-radius: $space-normal;
  padding: $space-large;
  margin: $space-small;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;
  position: relative;
  max-width: 400px;
  min-height: 280px;
  display: flex;
  flex-direction: column;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  }

  .quote-icon {
    position: absolute;
    top: $space-normal;
    right: $space-normal;
    opacity: 0.3;
  }

  .testimonial-text {
    flex: 1;
    margin-bottom: $space-large;

    .text-content {
      font-size: $font-size-default;
      line-height: 1.6;
      margin: 0;

      :deep(.highlight) {
        background-color: rgba(65, 163, 35, 0.2);
        color: inherit;
        padding: 0 2px;
        border-radius: 2px;
        font-weight: $font-weight-medium;
      }
    }
  }

  .author-info {
    display: flex;
    align-items: flex-start;
    gap: $space-small;

    .author-avatar {
      flex-shrink: 0;

      .avatar-image {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid rgba(0, 0, 0, 0.1);
      }
    }

    .author-details {
      flex: 1;
      min-width: 0;

      .author-name {
        font-size: $font-size-default;
        font-weight: $font-weight-medium;
        margin: 0 0 $space-micro 0;
        line-height: 1.4;
      }

      .author-position {
        font-size: $font-size-mini;
        margin: 0 0 $space-micro 0;
        line-height: 1.3;
      }

      .company-info {
        display: flex;
        align-items: center;
        gap: $space-micro;

        .company-logo {
          width: 20px;
          height: 20px;
          object-fit: contain;
          border-radius: 2px;
        }

        .company-name {
          font-size: $font-size-mini;
          line-height: 1.3;
        }
      }
    }
  }

  .rating {
    margin-top: $space-small;
    padding-top: $space-small;
    border-top: 1px solid rgba(0, 0, 0, 0.1);

    .stars {
      display: flex;
      gap: 2px;

      .star {
        font-size: 16px;
        color: #fbbf24;
        
        &.empty {
          color: #d1d5db;
        }
      }
    }
  }
}

// Dark mode adjustments
:global(.dark) .testimonial-card {
  .author-info .author-avatar .avatar-image {
    border-color: rgba(255, 255, 255, 0.2);
  }

  .rating {
    border-top-color: rgba(255, 255, 255, 0.2);
  }
}

// Responsive design
@media (max-width: 768px) {
  .testimonial-card {
    margin: $space-smaller;
    padding: $space-normal;
    min-height: auto;

    .author-info {
      .author-avatar .avatar-image {
        width: 40px;
        height: 40px;
      }
    }
  }
}
</style>

