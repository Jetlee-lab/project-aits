import { useMemo } from 'react'
import { useSelector } from 'react-redux'
import { selectCurrentUser } from '@/features/auth/auth-slice'

export const useAuth = () => {
  const user = useSelector(selectCurrentUser)

  return useMemo(() => ({ user }), [user])
}
