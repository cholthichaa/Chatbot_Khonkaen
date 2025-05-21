import { mdiMonitor, mdiAccountGroup, mdiFileEditOutline, mdiForumPlus, mdiWebCheck } from '@mdi/js'

export default [
  {
    to: '/dashboard',
    icon: mdiMonitor,
    label: 'Dashboard'
  },
  {
    to: '/User',
    label: 'User',
    icon: mdiAccountGroup
  },
  {
    to: '/Conversations',
    label: 'Conversation',
    icon: mdiForumPlus
  },
  {
    to: '/Web_Answers',
    label: 'Web Answers',
    icon: mdiWebCheck
  },
  {
    to: '/Places',
    label: 'Places',
    icon: mdiFileEditOutline
  },
  {
    to: '/FlexMessage',
    label: 'FlexMessage',
    icon: mdiFileEditOutline
  },
  {
    to: '/Event',
    label: 'Event',
    icon: mdiFileEditOutline
  }
  
]
