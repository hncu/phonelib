package phonelibv2



import org.junit.*
import grails.test.mixin.*

@TestFor(LibbookController)
@Mock(Libbook)
class LibbookControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/libbook/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.libbookInstanceList.size() == 0
        assert model.libbookInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.libbookInstance != null
    }

    void testSave() {
        controller.save()

        assert model.libbookInstance != null
        assert view == '/libbook/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/libbook/show/1'
        assert controller.flash.message != null
        assert Libbook.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/libbook/list'


        populateValidParams(params)
        def libbook = new Libbook(params)

        assert libbook.save() != null

        params.id = libbook.id

        def model = controller.show()

        assert model.libbookInstance == libbook
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/libbook/list'


        populateValidParams(params)
        def libbook = new Libbook(params)

        assert libbook.save() != null

        params.id = libbook.id

        def model = controller.edit()

        assert model.libbookInstance == libbook
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/libbook/list'

        response.reset()


        populateValidParams(params)
        def libbook = new Libbook(params)

        assert libbook.save() != null

        // test invalid parameters in update
        params.id = libbook.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/libbook/edit"
        assert model.libbookInstance != null

        libbook.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/libbook/show/$libbook.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        libbook.clearErrors()

        populateValidParams(params)
        params.id = libbook.id
        params.version = -1
        controller.update()

        assert view == "/libbook/edit"
        assert model.libbookInstance != null
        assert model.libbookInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/libbook/list'

        response.reset()

        populateValidParams(params)
        def libbook = new Libbook(params)

        assert libbook.save() != null
        assert Libbook.count() == 1

        params.id = libbook.id

        controller.delete()

        assert Libbook.count() == 0
        assert Libbook.get(libbook.id) == null
        assert response.redirectedUrl == '/libbook/list'
    }
}
