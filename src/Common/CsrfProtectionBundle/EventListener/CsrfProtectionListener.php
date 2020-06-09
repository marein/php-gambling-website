<?php
declare(strict_types=1);

namespace Gaming\Common\CsrfProtectionBundle\EventListener;

use Gaming\Common\CsrfProtectionBundle\Guard\Guard;
use Symfony\Component\HttpKernel\Event\RequestEvent;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;

final class CsrfProtectionListener
{
    /**
     * @var Guard
     */
    private Guard $guard;

    /**
     * CsrfProtectionListener constructor.
     *
     * @param Guard $guard
     */
    public function __construct(Guard $guard)
    {
        $this->guard = $guard;
    }

    /**
     * Protect against CSRF attacks with the help of standard headers.
     *
     * @param RequestEvent $event
     *
     * @throws AccessDeniedHttpException When a CSRF attack is detected.
     */
    public function onKernelRequest(RequestEvent $event): void
    {
        if ($event->isMasterRequest() && !$this->guard->isSafe($event->getRequest())) {
            throw new AccessDeniedHttpException('CSRF attack detected.');
        }
    }
}
