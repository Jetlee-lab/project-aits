from rest_framework import viewsets, mixins
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import logout

from ..models import ActiveSession


class LogoutViewSet(viewsets.GenericViewSet, mixins.CreateModelMixin):
    permission_classes = (IsAuthenticated,)

    def create(self, request, *args, **kwargs):
        user = request.user

        session = ActiveSession.objects.get(user=user)
        session.delete()

        logout(request)

        return Response(
            {"success": True, "msg": "Token revoked"}, status=status.HTTP_200_OK
        )
