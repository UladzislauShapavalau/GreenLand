<?php

declare(strict_types=1);

namespace App\Controller\Location;

use App\DTO\Location\CreateLocationApiSchema;
use App\Exception\ApiException;
use App\Exception\AppException;
use App\Normalizer\LocationNormalizer;
use App\Normalizer\UserNormalizer;
use App\Repository\LocationRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Attribute\AsController;
use Symfony\Component\HttpKernel\Attribute\MapRequestPayload;
use Symfony\Component\Routing\Attribute\Route;

#[AsController]
#[Route(path: '/api/locations', name: 'api.locations.create', methods: Request::METHOD_POST)]
class CreateAction extends AbstractController
{
    /**
     * @param Request $request
     * @param LocationRepository $repository
     * @param CreateLocationApiSchema $schema
     * @return Response
     * @throws ApiException
     */
    public function __invoke(
        Request $request,
        LocationRepository $repository,
        #[MapRequestPayload] CreateLocationApiSchema $schema
    ): Response {
        try {
            $location = $repository->create($schema->name);
        } catch (AppException $e) {
            throw new ApiException($e);
        }

        return $this->json($location, Response::HTTP_OK, [], [
            LocationNormalizer::CONTEXT_TYPE_KEY => LocationNormalizer::DEFAULT_TYPE,
            UserNormalizer::CONTEXT_TYPE_KEY => UserNormalizer::ID_ONLY_TYPE,
        ]);
    }
}
